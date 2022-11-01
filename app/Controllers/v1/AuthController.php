<?php 
namespace App\Controllers\v1;

use App\Controllers\AccessBridge;
use App\Models\v1\AuthModel;

class AuthController extends AccessBridge {

    private $auth_model;
    private $token_expiry = 12;

    public function __construct()
    {
        $this->auth_model = new AuthModel;
    }

    /**
     * Process the user login procedure
     * 
     * @param       String  $params['username']
     * @param       String  $params['password']
     * 
     * @return Array
     */
    public function login(array $params) {

        try {

            $data = $this->auth_model->where('username', $params['username'])
                                    ->orWhere('index_number', $params['username'])
                                    ->limit(1);

            $result = $data->get();

            $data = !empty($result) ? $result->getResultArray() : [];
            
            if( empty($data) ) {
                return 'Sorry! The credentials could not be authenticated.';
            }

            if(!empty($data)) {

                // if the status is not equal to one
                if($data[0]['status'] !== '1') {
                    return lang('Errors.invalidCredential');
                }
                
                // verify the user password
                if(!password_verify($params['password'], $data[0]['password'])) {
                    return lang('Errors.invalidCredential');
                }

                // update the last login
                $this->auth_model->db->table('users')->update(['last_login' => date('Y-m-d H:i:s')], ['id' => $data[0]['id']], 1);

                // get the api version
                $params['version'] = empty($params['version']) ? $params['api_version'] : $params['version'];

                // set the response
                $response['user'] = $this->user_data($data[0]['id'], $params['version']);

                // delete the password if exists
                if(isset($response['user']['password'])) {
                    unset($response['user']['password']);
                }

                // get the user token variable
                $response['token'] = $this->access_token($data[0]['id'], $data[0]['client_id'], $data[0]['username']);

                $session = session();
                $session->set([
                    '_userName' => $response['user']['username'],
                    '_clientId' => $response['user']['client_id'],
                    '_userId' => $response['user']['id'],
                    '_userGroup' => ucfirst($response['user']['group_name']),
                    '_userApiToken' => $response['token']
                ]);
                $session->remove(['_userData']);

                // get the user agent
                $request = \Config\Services::request();
                $userAgent = $request->getUserAgent();
                
                // set the user agent
                $user_agent = $userAgent->__toString();
                $ip_address = $request->getIPAddress();

                // log the user login accesss history
                $this->auth_model->db->table('login_history')->insert([
                    'client_id' => $response['user']['client_id'],
                    'username' => $response['user']['username'],
                    'user_id' => $response['user']['id'],
                    'ip_address' => $ip_address,
                    'user_agent' => $user_agent
                ]);

                return [
                    'code' => 200, 
                    'result' => 'Login was successful.',
                    'additional' => $response
                ];
            }

        } catch(\Exception $e) {
            return [];
        }

    }

    /**
     * Generate an access token for a user
     * 
     * @param Int       $userId
     * 
     * @return Array
     */
    public function access_token($userId, $schoolId = null, $username = null) {

        // create the temporary accesstoken
        $token = random_string("alnum", 64);
        $expiry = date("Y-m-d H:i:s", strtotime("+{$this->token_expiry} hours"));

        // most recent query
        $recent = $this->previous_token($userId, $schoolId);

        // generate the access token
        $access = base64_encode("{$userId}:{$username}:{$token}:{$schoolId}");

        // if within the last 10 minutes
        if($recent) {
            $access = $recent;
        }
        
        try {

            // if $recent is empty
            if(empty($recent)) {

                // delete all temporary tokens
                $this->auth_model->db
                        ->query("UPDATE users_tokens SET status = 'inactive'
                            WHERE (TIMESTAMP(expiry_timestamp) < CURRENT_TIME()) 
                            AND status = 'active' AND user_id = '{$userId}' LIMIT 100");

                // insert a new token
                $this->auth_model->db->table('users_tokens')
                        ->insert([
                            'user_id' => $userId, 'token' => $access, 'expired_at' => $expiry,
                            'client_id' => $schoolId, 'expiry_timestamp' => strtotime($expiry), 
                        ]);
            }

            // return the access token information
            return $access;

        } catch(\Exception $e) {
            return $e->getMessage();
            return 'Error generating access token';
        } 
    }

    /**
     * If the user's last key generated is within a 10 minutes span
     * Then deny regeneration
     * 
     * @param String    $userId      The userId to use in loading record
     * 
     * @return Bool
     */
    private function previous_token($userId, $schoolId) {

        // run a query
        $stmt = $this->auth_model->db
                    ->table('users_tokens')
                    ->where(['user_id' => $userId, 'status' => 'active', 'client_id' => $schoolId])
                    ->orderBy('id', 'DESC')
                    ->limit(1)
                    ->get();
        
        $data = !empty($stmt) ? $stmt->getResultArray() : [];

        // get the time of creation
		$lastToken = !empty($data) ? $data[0]['expired_at'] : 0;
        
        // if the last update was parsed
		return (!empty($lastToken) && strtotime($lastToken) > time()) ? $data[0]['token'] : null;
	
    }

    /**
     * Get the Full employee data
     * 
     * @param   Int     $userId     The unique employee
     * @param   String  $version    The version of the api in play
     * @param   String  $token      This is a new access token generated
     * 
     * @return Array
     */
    public function user_data($userId = null, $version = null, $token = null) {

        try {
            
            // set the controller name
            $classname = "\\App\\Controllers\\".$version."\\UsersController";

            // create a new class for handling the resource
            $usersObject = new $classname();

            // return the user data
            return $usersObject->show([], $userId, $token);

        } catch(\Exception $e) {
            return [];
        }

    }

    /**
     * Validate Access Token
     * 
     * @param       String  $authToken      This is the api token to validate
     * @param       String  $api_version    This is the current api version in play
     * @param       Object  $session        This is an object of the session class
     * 
     * @return Array
     */
    public function validate_token($authToken, $api_version, $session = null) {
        
        // if the token does not contain the keyword Bearer then end the query
        if( !contains($authToken, ['Bearer'])) {
            return 'Invalid token parsed.';
        }

        $session = !empty($session) ? $session : session();

        // clean the token
        $authToken = trim(str_ireplace(['Bearer', 'Authorization:', 'Authorization'], '', $authToken));
        
        // run a query
        $stmt = $this->auth_model->db
                    ->table('users_tokens t')
                    ->where(['t.token' => $authToken, 't.status' => 'active'])
                    ->join('users u', 'u.id = t.user_id', 'left')
                    ->orderBy('t.id', 'DESC')
                    ->limit(1)
                    ->get();
        
        // get the response data
        $data = !empty($stmt) ? $stmt->getResultArray() : [];
        
        // if the token was not found then end the query
        if(empty($data)) {
            
            // decode the auth token
            $decode = base64_decode($authToken);
            $split = explode(':', $decode);

            // if the third parameter is set
            if(isset($split[3])) {
                // if the user
                if(in_array($split[1], ['spiritual', 'appuser'])) {
                    return 'refresh_token:' . $this->access_token($split[0], $split[3], $split[1]);
                }
            }

            // sent the response
            return 'The access "'.$authToken.'" token could not be authenticated.';
        }

        // get the time of creation
		$lastToken = !empty($data) ? $data[0]['created_at'] : 0;

        // regenerate the token if the user is appuser
        $NotExpired = !empty($lastToken) && (time() <= $data[0]['expiry_timestamp']);
        
        // confirm if an app user
        if(empty($NotExpired)) {

            // if the username is the main frontend appuser or super admin spiritual
            if(in_array($data[0]['username'], ['spiritual', 'appuser'])) {
                // regenerate a new token for the user
                return 'refresh_token:' . $this->access_token($data[0]['user_id'], $data[0]['client_id'], $data[0]['username']);
            }

            else if( !empty($session->_isLocalAccess) && !empty($session->_userId) && !empty($session->_userApiToken) ) {
                // if the access token has expired
                $session->_userApiToken = $this->access_token($session->_userId, $session->_clientId, $session->_userName);

                // reset the not expired variable
                $NotExpired = true;
            }
            
        }
        
        // confirm if the access token has not yet expired
		if($NotExpired) {
            
            try {
                
                // update the last login
                $this->auth_model->db->table('users')->update(['last_login' => date('Y-m-d H:i:s')], ['id' => $data[0]['user_id']], 1);

                // return the user data
                return $this->user_data($data[0]['user_id'], $api_version);

            } catch(\Exception $e) {
                // remove the access token from the system
                $this->auth_model->db->query("UPDATE users_tokens SET status = 'inactive' WHERE token = '{$authToken}' AND status='active' LIMIT 1");

                // return error message
                return 'Sorry! You cannot use this access token because the user does no exist on the system.';
            }

        } else {
            return 'The access token submitted has expired. Login to generate a new token.';
        }

    }

}
?>