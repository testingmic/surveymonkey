<?php
namespace App\Controllers;

use CodeIgniter\API\ResponseTrait;

class AppController extends ApiServices {

    use ResponseTrait;

    public $AppAdminURL;
    public $sessObject;
    public $imageObject;
    private $appIsDown = false;
    public $accepted_images_types = ".jpg,.png,.jpeg";
    public $permission_denied = "Sorry! You are not permitted to access this resource.";
    public $processing_error = "Sorry! An unexpected error was encountered while processing the request.";

    public function __construct()
    {
        $this->sessObject = session();
        $this->imageObject = \Config\Services::image();
        $this->baseURL = trim(config('App')->baseURL, '/');
        
        // if the token in session is empty
        if( empty($this->sessObject->_generalAPIToken)) {
            // Get the Token file
            $TokenFile = APPPATH . "Files/System.json";
            // if is load then load it and append the data in it
            if(is_file($TokenFile) && file_exists($TokenFile)) {
                $TokenFile = json_decode(file_get_contents($TokenFile), true);
                $this->sessObject->set(['_generalAPIToken' => $TokenFile['token'], '_isLocalAccess' => true]);
            }
        }

    }

    /**
     * Modify content to parse
     * 
     * @return String
     */
    public function not_found_text($section = null) {
        return "This survey has been deleted or you are not authorized to access this page.";
    }

    /**
     * Display the file
     * 
     * @param String $filename
     * 
     * @return Mixed
     */
    public function show_display($filename, $data = []){

        try {
            // set the count
            $data['count'] = 1;

            if( !empty($this->sessObject->_userData) ) {
                $data['metadata'] = $this->sessObject->_userData['metadata'];
            }
            
            // show the page
            return view($filename, $data);
        } catch(\Exception $e) {
            return $e->getMessage();
        }
    }


    /**
     * Api Request Response
     * 
     * @param String        $method
     * @param String        $page
     * @param Array|String  $request
     * @param String        $title      The name of the object being created
     * 
     * @return Array
     */
    public function api_response($request, $method = "GET", $page = null) {
        
        $info['code'] = $request['code'] ?? 203;
        $method = strtoupper($method);

        if(isset($request['result'])) {
            $info['data']['result'] = $request['result'];
            $info['data']['additional'] = $request['additional'] ?? null;
        }

        if( in_array($info['code'], [200, 201]) ) {
            $item_name = $request['result']['title'] ?? ($request['result']['username'] ?? ucwords($page));

            if( isset($request['result']['id']) ) {

                if( $method == 'POST' ) {
                    $info['data']['result'] = "{$item_name} record successfully created.";

                    $info['data']['additional'] = [
                        'clear' => true,
                        'href' => "{$page}/modify/{$request['result']['slug']}/edit"
                    ];
                    
                } elseif( ($method == 'PUT') ) {
                    
                    $info['data']['result'] = "{$item_name} record successfully updated.";

                    if(isset($request['additional'])) {
                        $info['data']['additional'] = $request['additional'];
                    }
                }
            }
            
        }

        elseif($method == "DELETE") {

            if(isset($request['code'])) {
                return $this->respond($request, 200);
            }

            if(contains($request, ['has successfully been deleted'])) {
                $info['code'] = 200;
                $info['data']['result'] = $request;
            } else {
                $info['code'] = 200;
                $info['data']['result'] = $request;
            }

        }

        elseif( !is_array($request) || !isset($request['code']) ) {
            $info['data']['result'] = $request;
        }

        if( empty($info['data']['additional']) ) {
            unset($info['data']['additional']);
        }

        return $this->respond($info, 200);
    }

    /**
     * Return an error response
     * 
     * @param String        $response
     * 
     * @return JSON
     */
    public function error($response = null, $code = 203) {
        return $this->respond(['code' => $code, 'data' => ['result' => $response]], 200);
    }

    /**
     * Delete a Record
     * 
     * @param   String      $params['record']
     * @param   Int         $params['record_id']
     * 
     * @return Array
     */
    public function delete() {

        $record = $this->request->getVar('record');
        $record_id = $this->request->getVar('record_id');

        if( empty($record) || empty($record_id) ) {
            return 'Ensure the record and record_id variables are not empty.';
        }

        $request = $this->api_lookup("DELETE", "{$record}/{$record_id}");

        return $this->api_response("DELETE", $record, $request);
    }

    /**
     * Change the Status of a record
     * 
     * @param   String      $params['record']
     * @param   Int         $params['record_id']
     * 
     * @return Array
     */
    public function status() {

        $record = $this->request->getVar('record');
        $record_id = $this->request->getVar('record_id');

        if( empty($record) || empty($record_id) ) {
            return 'Ensure the record and record_id variables are not empty.';
        }

        $request = $this->api_lookup("PUT", "{$record}/state", ['primary_key' => $record_id]);

        if( isset($request['code']) && ($request['code'] == 200) ) {
            $status = $request['result']['status'] ?? $request['result'][0]['status'];
            $request['additional']['status_id'] = (int) $status;
            $request['code'] = 200;
            $request['result'] = $request['result'][0] ?? $request['result'];
        }
        
        return $this->api_response("PUT", $record, $request);
    }
    
}
