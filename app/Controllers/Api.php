<?php

namespace App\Controllers;

use App\Models\ApiModel;
use CodeIgniter\API\ResponseTrait;

class Api extends BaseController {

    use ResponseTrait;

    protected $_userId;
    protected $accessCheck = [];
    protected $_userData;

    protected $response_code = 200;
    protected $request;
    protected $api_model;
    protected $class_method;
    protected $endpoints;
    protected $primaryKey;
    protected $inner_url;
    protected $req_method;
    protected $req_params;
    protected $apiConfig;
    protected $default_params;
    protected $request_endpoint;
    protected $global_limit = 250;
    protected $AuthorizationToken;
    protected $accepted_variables;

    // keys to exempt when processing the request parameter keys
    protected $keys_exempted = [
        "ip_address", "shsAdmission", "access_token", "_ga", 
        "limit", "offset", "full_search", "orderBy", "the_button"
    ];

    // keys to bypass when checking for the csrf_token
    protected $bypass_csrf_token_list = ['_logout', 'ajax_cronjob'];

    public function __construct() {

        $this->request = \Config\Services::request();

        // api configuration file
        $this->apiConfig = config('Api');

        // set the api global variable
        $this->allowed_methods = $this->apiConfig->allowed_methods;
        $this->api_version = $this->apiConfig->api_version;
        $this->available_versions = $this->apiConfig->versions_list;
    }

    /**
     * Receive the incoming request and process it.
     * 
     * It will validate the Api Keys, Request Endpoint & Request Parameters
     * The resulting data will be processed and returned as a JSON
     * 
     * @param String    $version_inner
     * @param String    $resource_endpoint
     * @param String    $resource
     * @param String    $primary_key
     * 
     * @return Array
     */
    public function index($init = null, string $first_url = null, $second_url = null, $primary_key = null, $last_url = null) {

        // get the request method
        $this->req_method = strtoupper($this->request->getMethod());
        $version_passed = (bool) in_array($first_url, $this->available_versions);

        // run a query to check if the user has parsed a version
        if($version_passed) {
            $this->api_version = $first_url;
            $first_url = $second_url;
            $second_url = $primary_key;
        } else {
            $primary_key = $second_url;
        }

        // set new parameters
        if( !empty($last_url) ) {
            $second_url = $primary_key;
            $primary_key = $last_url;
        }

        // set the full endpoint url and breakdown
        $this->request_endpoint = trim($first_url, '/');
        $this->inner_url = trim($first_url, '/');

        // set the primary key
        $this->primaryKey = $primary_key;

        // get the request path
        $this->req_path = $this->request->getPath();

        // get the variables
        $mainParam = [];
        $get_param = $this->request->getGet();
        $mainParam = array_merge($mainParam, !empty($get_param) ? $get_param : []);
        $get_post = $this->request->getPost();
        $mainParam = array_merge($mainParam, !empty($get_post) ? $get_post : []);
        $get_json = $this->request->getJSON();
        $get_json = !empty($get_json) ? (array) $get_json : [];
        $mainParam = array_merge($mainParam, $get_json);
        
        $post_get_params = array_map('esc', $mainParam);
        
        // set the files list
        $files_list = $this->request->getFiles();

        // merge the post, get and files items
        $t_params = array_merge($post_get_params, $files_list);

        // get the user agent
        $userAgent = $this->request->getUserAgent();
        
        // set the user agent
        $this->user_agent = $userAgent->__toString();
        $this->ip_address = $this->request->getIPAddress();
        
        if(in_array($this->req_method, ["PUT", "DELETE"]) && empty($this->primaryKey)) {
            return $this->respond($this->requestOutput(405), 405);
        }

        // set the array to bypass
        $end_url_primary_key = $this->apiConfig->putAppend;
        
        // $outer_url check
        if(!empty($this->primaryKey) && !preg_match("/^[0-9,]+$/", $this->primaryKey) && !in_array($this->primaryKey, $end_url_primary_key)) {
            return $this->respond($this->requestOutput(400, $this->outputMessage(400)), 400);
        }

        // if the request is post
        if( !empty($this->primaryKey) && in_array($this->req_method, ["POST"]) && !in_array($this->primaryKey, $end_url_primary_key)) {
            return $this->respond($this->requestOutput(405, $this->outputMessage(405)), 405);
        }

        // get the authorization header parsed token
        $this->AuthorizationToken = $this->request->header('Authorization');

        // set the method to use
        if(in_array($this->primaryKey, $end_url_primary_key)) {
            $this->class_method = $primary_key;
        } else {
            $this->class_method = (!empty($last_url) ? $second_url : ($this->apiConfig->allowed_methods[$this->req_method] ?? "index"));
        }
        
        // set the default parameters
        $this->req_params = $t_params;

        /** Process the API Request */
        $make_request = $this->initRequest($t_params);
        
        // set the data to return
        return $this->respond($make_request, $this->response_code);
        
    }

    /**
     * Load the endpoint information for processing
     * 
     * @param Array $params         This is an array of the parameters parsed in the request
     * @param String $method        The request method
     * 
     * @return Array
     */
    private function initRequest($params) {

        /** Split the endpoint */
        $expl = explode("/", $this->request_endpoint);
        $endpoint = isset($expl[1]) && !empty($expl[1]) ? strtolower($this->request_endpoint) : null;

        // trim the edges
        $endpoint = trim($endpoint, '/');

        /* Run a check for the parameters and method parsed by the user */
        $paramChecker = $this->keysChecker($params);

        // if an error was found
        if( $paramChecker['code'] !== 100) {
            // print the json output
            return $paramChecker;
        }

        // run the request
        $ApiRequest = $this->requestHandler($params);
        
        // remove access token if in
        if(isset($params["access_token"])) {
            unset($params["access_token"]);
        }

        // return out the response
        return $ApiRequest;
    }

    /**
     * This method checks the params parsed by the user
     * 
     *  @param {array} $params  This is the array of parameters sent by the user
    */
    private function keysChecker(array $params) {
        
        /** Endpoint File */
        $endpoint_file = APPPATH . 'Files/Endpoints.json';

        /** If the not file or it does not exits */
        if(!is_file($endpoint_file) || !file_exists($endpoint_file)) {
            $this->requestOutput(404);
        }

        /** Load the Endpoint JSON File **/
        $db_req_params = json_decode(file_get_contents(APPPATH . '/Files/Endpoints.json'), true);
        
        /**
         * check if there is a valid request method in the endpoints
         * 
         * Return an error / success message with a specific code
         */
        if( !isset($db_req_params[$this->request_endpoint][$this->req_method]) ) {
            
            // set the code to return 
            $code = empty($this->inner_url) ? 200 : 404;

            // set the response code
            $this->response_code = $code;

            // return error if not valid
            return $this->requestOutput($code, $this->outputMessage($code));

        } elseif( !in_array($this->class_method, ['index']) && !isset($db_req_params[$this->request_endpoint][$this->req_method][$this->class_method]) ) {
            
            // set the code to return 
            $code = empty($this->inner_url) ? 200 : 404;

            // set the response code
            $this->response_code = $code;

            // return error if not valid
            return $this->requestOutput($code, $this->outputMessage($code));
        } else {
            
            // set the acceptable parameters
            $accepted =  $db_req_params[$this->request_endpoint][$this->req_method][$this->class_method] ?? [];

            // set the endpoint sub requests
            $this->accepted_variables = $accepted;

            // confirm that the parameters parsed is not more than the accpetable ones
            if(empty(array_keys($accepted)) && !empty($params)) {
                
                return $this->requestOutput(203, ["result" => $this->outputMessage(203), "accepted" => $accepted]);

            } else if(empty(array_keys($accepted))) {
                // return all tests parsed
                return $this->requestOutput(100, $this->outputMessage(200));
            }

            else {
                
                // get the keys of all the acceptable parameters
                $endpointKeys = array_keys($accepted);
                $errorFound = [];
                
                // confirm that the supplied parameters are within the list of expected parameters
                foreach($params as $key => $value) {
                    if(!in_array($key,  $this->keys_exempted) && !in_array($key, $endpointKeys)) {
                        // set the error variable to true
                        $errorFound[] = $key;                   
                        // break the loop
                        break;
                    }
                }

                // if an invalid parameter was parsed
                if($errorFound) {
                    // return invalid parameters parsed to the endpoint
                    return $this->requestOutput(405, [
                        'accepted' => ["parameters" => $accepted],
                        'invalids' => $errorFound
                    ]);
                } else {

                    /* Set the required into an empty array list */
                    $required = [];
                    $required_text = null;
                    $validate_rules = [];

                    // loop through the accepted parameters and check which one has the description 
                    // required and append to the list
                    foreach($accepted as $key => $value) {
                        // evaluates to true
                        if(strpos($value, "required") !== false) {
                            $required[] = $key;
                            $required_text .= $key . ": is required.\n";
                        }
                    }

                    /**
                     * Confirm the count using an array_intersect
                     * What is happening
                     * 
                     * Get the keys of the parsed parameters
                     * count the number of times the required keys appeared in it
                     * 
                     * compare to the count of the required keys if it matches.
                     * 
                     */
                    $confirm = (count(array_intersect($required, array_keys($params))) == count($required));
                    
                    // If it does not evaluate to true
                    if(!$confirm) {
                        // return the response of required parameters
                        return $this->requestOutput(401, ['result' => $required_text, 'accepted' => $accepted]);
                    }

                    // loop through the accepted parameters and check which one has the description 
                    // required and append to the list
                    foreach($accepted as $key => $value) {

                        // if the rules are not empty
                        if((!empty($value) && isset($params[$key]))) {

                            // validate all the various data parsed
                            $param_value = str_ireplace('|', '&', $value);
                            parse_str($param_value, $rules);

                            // if the rules for the endpoint is not empty
                            if(!empty($rules)) {
                                // permform validation
                                $val = validate_value($rules, $params[$key], $key);
                                
                                // validation
                                if(!empty($val)) {
                                    $validate_rules[] = $val;
                                }
                            }
                        }

                    }

                    if(!empty($validate_rules)) {
                        $rules = "";
                        foreach($validate_rules as $value) {
                            foreach($value as $item) {
                                $rules .= $item . "\n ";
                            }
                        }
                        $rules = trim(trim($rules), '\n');
                        
                        // set the response code
                        $this->response_code = 203;
                        return $this->requestOutput(400, ['result' => $rules]);
                    }
                    
                    return $this->requestOutput(100, $this->outputMessage(200));

                }

            }

        }

    }

    /**
     * Outputs to the screen
     * 
     * @param Int                   $code   This is the code after processing the user request
     * @param Mixed{string/array}    $data   Any addition data to parse to the user
     */
    private function requestOutput($code, $message = null) {
        // format the data to return
        $data = [ 'code' => $code ];

        // unset code from data
        if(isset($message['code'])) {
            unset($message['code']);
        }

        ( !empty($message) ) ? ($data['data'] = $message) : $data['data'] = [];

        return $data;
    }

    /**
     * This is the output message based on the code
     * 
     * @param Int $code
     * 
     * @return String
     */
    private function outputMessage($code) {

        $description = [
            200 => "The request was successfully executed and returned some results.",
            201 => "The request was successful however, no results was found.",
            205 => "The record was successfully updated.",
            202 => "The data was successfully inserted into the database.",
            203 => "Invalid parameters parsed to the endpoint.",
            204 => "No Content Found.",
            400 => "Invalid request method parsed.",
            401 => "Sorry! Please ensure all required fields are not empty.",
            403 => "Variable validation errors found.",
            404 => "Page not found.",
            405 => "Method not accepted.",
            100 => "All tests parsed",
            500 => "The request method does not exist.",
            501 => "Sorry! You do not have the required permissions to perform this action.",
            502 => "The access token could not be authenticated.",
            600 => "Sorry! Your current subscription does not grant you permission to perform this action.",
            700 => "Unknown request parsed",
            999 => "An error occurred please try again later",
            1000 => "Blocked!!! CSRF Attempt"
        ];
        
        return $description[$code] ?? $description[700];
    }

    /**
     * This handles all requests by redirecting it to the appropriate
     * Controller class for that particular endpoint request
     * 
     * @param stdClass $params         - This the array of parameters that the user parsed in the request
     * 
     * @return  Array
     */
    private function requestHandler() {

        // preset the response
        $code = $this->response_code = 401;
        $result = ['result' => $this->outputMessage(501)];

        // set the parameters
        $authorized = false;
        $params = $this->req_params;
        $params['_apiRequest'] = false;

        // automatically set the limit if the primary key is set
        if( !empty($this->primaryKey) ) {
            $params['limit'] = 1;
        }

        // full class and method
        $class_and_method = "{$this->inner_url}/{$this->class_method}";

        // set the request as having been authorized
        if(in_array($class_and_method, ['auth/verify', 'auth/login', 'users/resetpassword'])) {
            $authorized = true;
        }

        // create a new session
        $params['ci_session'] = $this->session;

        // if the authorization token is not empty
        if( empty($authorized) ) {
            
            // if the auth token and variable were not parsed
            if( empty($this->AuthorizationToken) && empty($params['ci_session']->_userApiToken) && empty($params['access_token']) ) {
                // output the results
                return $this->requestOutput($code, $this->outputMessage(502));
            }

            // set the access token here
            $params['access_token'] = !empty($params['access_token']) ? $params['access_token'] : $this->AuthorizationToken;
            
            // set the authorization token
            $token = !empty($params['access_token']) ? "Bearer {$params['access_token']}" : "Bearer {$params['ci_session']->_userApiToken}";
            
            // set the controller name
            $classname = "\\App\\Controllers\\".$this->api_version."\\AuthController";

            // confirm if the class actually exists
            if(class_exists($classname)) {

                // create a new class for handling the resource
                $authObject = new $classname();
                $validate = $authObject->validate_token($token, $this->api_version, $params['ci_session']);

                // set the result content if the validation was successful
                $authorized = (bool) is_array($validate);
                $result['result'] = $validate;
                $this->response_code = is_array($validate) ? 200 : 403;
                
                // reset the response code
                $code = $this->response_code;

                // set the user information as a variable for the request
                if( is_array($validate) ) {
                    $params['_userData'] = $validate;
                    $result['result'] = $this->outputMessage(200);
                }

                // if an api request
                $params['_apiRequest'] = true;
            }
            
        }

        // if the user is authorized to make the query
        if( !empty($authorized) ) {

            // reqest made via api request
            $params['remote'] = (bool) isset($apiKeyValidation);

            // set the default limit to 1000
            $params['_limit'] = isset($params['limit']) ? (int) $params['limit'] : $this->global_limit;
            
            // parse the request method
            $params['req_method'] = $this->req_method;

            // set the classname
            $classname = "\\App\\Controllers\\".$this->api_version."\\".ucfirst($this->inner_url)."Controller";
            
            // confirm if the class actually exists
            if( !class_exists($classname) ) {
                $this->response_code = 400;
                return $this->requestOutput(400, $this->outputMessage(400));
            }
            
            // create a new class for handling the resource
            $classObject = new $classname($this->accepted_variables);
            
            // confirm if the method exists
            if( !method_exists($classObject, $this->class_method) ) {
                $this->response_code = 400;
                return $this->requestOutput(400, $this->outputMessage(400));
            }

            // set the method to load
            $method = $this->class_method;
            
            // set additional parameters
            $params['user_agent'] = $this->user_agent;
            $params['ip_address'] = $this->ip_address;
            $params['api_version'] = $this->api_version;
            $params['_model_name'] = $this->inner_url;
            $params['_model_id'] = $this->primaryKey;
            $params['_model_request'] = $this->req_method;
            
            // convert the response into an arry if not already in there
            $request = $classObject->$method($params, $this->primaryKey);

            // if the class and method is to verify
            if(in_array($class_and_method, ['auth/verify'])) {
                $authController = new \App\Controllers\Auth();
                $request = $authController->verify($request, $params['ci_session']);
            }
            
            // set the response code to return
            $code = is_array($request) || isset($request['code']) ? ($request['code'] ?? 200) : 203;
            
            $this->response_code = $code;

            // set the result
            $result['result'] =  is_array($request) ? ($request["result"] ?? ($request["data"] ?? $request)) : $request;

            // if additional parameter was parsed
            if(is_array($request) && isset($request['additional'])) {
                // set the additional parameter
                $result['additional'] = $request["additional"];
            }

            // No content to display
            $this->response_code = $code;
            
        }
        
        // output the results
        return $this->requestOutput($code, $result);

    }

    /**
     * Page not found
     */
    public function pageNotFound() {
        // set the data to return
        return $this->respond(['code' => 404, 'data' => 'Page Not Found'], 404);
    }

}
?>