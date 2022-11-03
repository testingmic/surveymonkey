<?php
namespace App\Controllers;

use CodeIgniter\HTTP\Request;

class ApiServices extends BaseController {

	public $req_method;
	public $generalApi;
    public $_userApiToken;
	public $save_local_file;
	public $max_attachment_size = 25;
	public $accepted_file_types = ".pdf,.jpg,.png,.jpeg,.docx,.doc";
    public $server_uri = "http://localhost/survey/public/api/";
	
	private $class_method = 'list';
	private $global_limit = 500;
	private $ApiEndpoint;

    /**
	 * This is the start point for processing a either a GET, POST, PUT or DELETE request against the api
	 * 
	 * @param String		$method => either GET, POST, PUT or DELETE
	 * @param String		$endpoint => This is the endpoint to set as the url
	 * @param Array 		$params => parameters to set in the form_params field of the request
	 * 
	 * @return Array|String
	 */
	final function api_lookup($method = 'GET', $endpoint = null, $param = []) {        

		// if the request is through the command line
		if( is_cli() ) {
			die("Access denied.");
		}

		// init the session 
		$this->sessionObj = !empty($this->sessionObject) ? $this->sessionObject : session();

		// set the request method
		$this->req_method = strtoupper($method);

		// set the token for requests
		$this->_userApiToken = !empty($this->_userApiToken) ? $this->_userApiToken : $this->sessionObj->_userApiToken;

		if(empty($this->_userApiToken) && !empty($this->sessObject->_generalAPIToken)) {
			// set the api to use
			$this->_userApiToken = $this->sessObject->_generalAPIToken;
		}

		// print the results
		return $this->curl_request($endpoint, $param);
	}

	/**
	 * Load a Local File
	 * 
	 * If the save data is parsed, then it will save the data in the file
	 * 
	 * @param String	$filename
	 * @param Mixed		$save_data
	 * 
	 * @return Mixed
	 */
	final function local_file_handler($filename = null, $save_data = false) {

		// local file
		$localFile = APPPATH . "Files/".ucfirst($filename).".json";

		// if is load then load it and append the data in it
        if(is_file($localFile) && file_exists($localFile)) {
            $localFile = json_decode(file_get_contents($localFile), true);

			// if the request is not to save the file
			if( empty($save_data) ) {
				return $localFile;
			}
        }

		// if the save_data is not empty
		if(!empty($save_data)) {
			$file = fopen($localFile, 'w');
			fwrite($file, json_encode($save_data));
			fclose($file);
		}

		return false;
	}

    /**
	 * This is used by $this->curl_lookup
	 * 
	 * @param String	$endpoint
	 * @param Array		$params
	 * 
	 * @return Array
	 */
	private function curl_request(string $endpoint = null, $params = []) {

		// challenges with multipart/form-data resulted in using this endpoint to make
		return $this->postman($endpoint, $params ?? []);

	}

    /**
	 * A method to handle all post, put and delete requests
	 * 
	 * @param String 			$endpoint
	 * @param Mixed|Array		$form_params
	 * 
	 * @return Array|Mixed
	 */
	private function postman($endpoint, $params) {
		
		// append the session variable
		$session = $this->sessionObj;

		$split = explode('/', $endpoint);

		$class = $split[0];
		$second_url = $split[1] ?? null;
		$version = config('Api')->api_version;

		// set the classname
		$classname = "\\App\\Controllers\\".$version."\\".ucfirst($class)."Controller";

		// confirm if the class actually exists
		if( !class_exists($classname) ) {
			return [];
		}
		
		$end_url_primary_key = config('Api')->putAppend;

		// set the primary key
		$primary_key = null;

		// set the method to use
        if(in_array($second_url, $end_url_primary_key)) {
            $class_method = $second_url;
        } else {
            $class_method = !empty($second_url) ? $second_url : (config('Api')->allowed_methods[$this->req_method] ?? "index");
        }

		if(!empty($second_url) && preg_match("/^[0-9]+$/", $second_url)) {
			$class_method = config('Api')->allowed_methods[$this->req_method];
			$primary_key = $second_url;
		}

		/** Load the Endpoint JSON File **/
		$ApiEndpoint = json_decode(file_get_contents(APPPATH . '/Files/Endpoints.json'), true);

		/** Accepted variables */
		$accepted_variables = $ApiEndpoint[$class][$this->req_method][$class_method] ?? [];
		
		// create a new class for handling the resource
		$classObject = new $classname($accepted_variables);

		// confirm if the method exists
		if( !method_exists($classObject, $class_method) ) {
			return [];
		}

		// set the controller name
		$AuthClass = "\\App\\Controllers\\".$version."\\AuthController";

		// confirm if the class actually exists
		if(class_exists($AuthClass)) {

			// use the session value to make the request
			if( !empty($session->_userData) && empty($this->generalApi) ) {
				$params['_userData'] = $session->_userData;
			} else {
				// create a new class for handling the resource
				$authObject = new $AuthClass();
				$validate = $authObject->validate_token("Bearer {$this->_userApiToken}", $version);

				// if the response contains refresh_token:
				if(contains($validate, ['refresh_token:'])) {

					// then reset the token
					$this->_userApiToken = str_ireplace('refresh_token:', '', $validate);
					$this->sessionObj->set('_generalAPIToken', $this->_userApiToken);

					// create the file and write the token into the file
					$TokenFile = APPPATH . "Files/System.json";
					if(is_file($TokenFile) && file_exists($TokenFile)) {
						$content = json_decode(file_get_contents($TokenFile), true);
						$content['token'] = $this->_userApiToken;
					} else {
						$content['token'] = $this->_userApiToken;
					}
					$file = fopen($TokenFile, 'w');
					fwrite($file, json_encode($content));
					fclose($file);

					// make the request again
					return $this->postman($endpoint, $params);
				}

				// set the result content if the validation was successful
				$result['result'] = $validate;

				// set the user information as a variable for the request
				if( is_array($validate) ) {
					$params['_userData'] = $validate;

					// if the general api request is empty then dont save the value in session
					$session->set(['_userData' => $params['_userData']]);
				}
			
			}

			// if an api request
			$params['_apiRequest'] = true;
		}
		
		if( empty($params['_userData'])) {
			return [];
		}

		// set the default limit to 1000
		$params['_limit'] = isset($params['limit']) ? (int) $params['limit'] : $this->global_limit;
		$params['req_method'] = $this->req_method;

		// get the user agent
        $userAgent = \Config\Services::request()->getUserAgent();
        
        // set the user agent
        $this->user_agent = $userAgent->__toString();
        $this->ip_address = \Config\Services::request()->getIPAddress();

		// set the primary key
		$primary_key = $params['primary_key'] ?? $primary_key;
            
		// set additional parameters
		$params['user_agent'] = $this->user_agent;
		$params['ip_address'] = $this->ip_address;
		$params['api_version'] = $version;
		$params['_model_name'] = $class;
		$params['_model_id'] = $primary_key;
		$params['_model_request'] = $this->req_method;
		
		// convert the response into an arry if not already in there
		$request = $classObject->$class_method($params, $primary_key);

		if(in_array($this->req_method, ["GET"]) && isset($request['code'])) {
			if($request['code'] == 401 && contains($request['result'], ['are unauthorized to access'])) {
				$request = [];
			}
		}
		
		return $request;
		
	}
    
}
