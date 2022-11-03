<?php 
namespace App\Controllers;

class AccessBridge {

    public $permission_denied = ['code' => 401, 'result' => 'Sorry! You are unauthorized to access this resource.'];
    public $delete_successful = 'Record has successfully been deleted';
    public $record_not_found = "Sorry! Record detail could not be found";
    public $request_error = ['code' => 203, 'result' => "Sorry! An error occured while processing the request"];
    public $value_is_string = false;
    public $db_limit = 500;
    public $actObject;
    private $_model_name;
    public $session;

    // files to be uploaded favicon globals
    public $favicon_array = [
        'jpg' => 'fa fa-file-image', 'png' => 'fa fa-file-image',
        'jpeg' => 'fa fa-file-image', 'gif' => 'fa fa-file-image',
        'pjpeg' => 'fa fa-file-image', 'webp' => 'fa fa-file-image',
        'pdf' => 'fa fa-file-pdf', 'doc' => 'fa fa-file-word',
        'docx' => 'fa fa-file-word', 'mp3' => 'fa fa-file-audio',
        'mpeg' => 'fa fa-file-video', 'mpg' => 'fa fa-file-video',
        'mp4' => 'fa fa-file-video', 'mov' => 'fa fa-file-video', 
        'movie' => 'fa fa-file-video', 'webm' => 'fa fa-file-video',
        'qt' => 'fa fa-file-video', 'zip' => 'fa fa-archive',
        'txt' => 'fa fa-file-alt', 'csv' => 'fa fa-file-csv',
        'rtf' => 'fa fa-file-alt', 'xls' => 'fa fa-file-excel',
        'xlsx' => 'fa fa-file-excel', 'php' => 'fa fa-file-alt',
        'css' => 'fa fa-file-alt', 'ppt' => 'fa fa-file-powerpoint',
        'pptx' => 'fa fa-file-powerpoint', 'sql' => 'fa fa-file-alt',
        'flv' => 'fa fa-file-video', 'json' => 'fa fa-file-alt'
    ];

    /**
     * Where In
     * 
     * @param Array     $params
     * @param String    $route
     * 
     * @return Array
     */
    public function filterWhereIn($params, $route = null) {
        
        $data = [];
        $this->session = session();

        
        // multiple filters
        foreach( ['slug'] as $column ) {
            // append to the array
            if( !empty($params[$column]) ) {
                $value = string_to_array($params[$column]);
                $data["a.{$column}"] = array_map('esc', $value);
            }
        }

        // if the user has no permission to view all other clients
        if( !empty($params['_userData']) && !in_array($route, ['notifications'])) {
            if ( empty($this->permission_handler('clients', 'monitoring', $params['_userData'])) ) {
                if($route == 'clients') {
                    if(!in_array($params['_userData']['id'], [1])) {
                        $data['a.id'] = [$params['_userData']['client_id']];
                    }
                } else {
                    $data['a.client_id'] = [$params['_userData']['client_id']];
                }
            }
        }

        return $data;
    }

    /**
     * Data Validations and Grouping
     * 
     * @param Object    $db_model       The database object
     * @param Array     $params
     * @param Array     $accepted
     * @param Array     $additional     This is the an additional array to loop through
     * 
     * @return Array
     */
    public function dataValidationGrouping($db_model = [], $params = [], $accepted = [], $additional = []) {

        $param = [];

        // set the model name
        $this->_model_name = $params['_model_name'] ?? null;
        
        // group the values
        foreach($params as $key => $value) {
            if(in_array($key, array_keys($accepted))) {
                $column_value = $this->value_is_string ? (string) $value : clean_tags($value);
                $param[$key] = is_array($column_value) ? json_encode($column_value) : $column_value;
            }
        }

        if( in_array('client_id', $additional) && empty($param['client_id']) ) {
            $param['client_id'] = (int) $params['_userData']['client_id'];
        }

        // set additional data
        if( !empty($additional) && ($params['req_method'] === 'POST')) {
            if( in_array('created_by', $additional) ) {
                $param['created_by'] = $params['_userData']['id'];
            }
        }

        // if the user has no permission to view all other clients
        if(!empty($param['client_id'])) {
            if ( empty($this->permission_handler('clients', 'list', $params['_userData'])) && 
                ((int) $param['client_id'] !== (int) $params['_userData']['client_id'])
            ) {
                return "Sorry! An invalid school id was parsed in the request.";
            }
        }

        // confirm the school
        if(!empty($params['in_array_check'])) {
            foreach($params['in_array_check'] as $key => $value) {
                if(in_array($key, array_keys($param))) {
                    if(!in_array($param[$key], $value)) {
                        return "The accepted values for {$key} are: ".implode(", ", $value);
                    }
                }
            }
        }

        try {

            // confirm if the record actually exists
            if( !empty($params['required_validation']) ) {
                if ( !empty($db_model) ) {

                    foreach($params['required_validation'] as $table => $where_clause) {
                        $result = $db_model->db->table($table)->where($where_clause)->limit(1)->get();
                        $data = !empty($result) ? $result->getResultArray() : [];
                        if(empty($data)) {
                            return $this->record_not_found;
                        }
                        
                        if( $this->_model_name === $table ) {
                            $param['previous_record'] = $data[0];
                        }
                    }

                }
            }

            // validate some values
            if( !empty($params['column_validation']) ) {
                if ( !empty($db_model) ) {
                    foreach($params['column_validation'] as $column => $table) {
                        if(in_array($column, array_keys($param)) && !empty($param[$column])) {
                            $result = $db_model->db->table($table[1])->where([$table[0] => $param[$column]])->limit(1)->get();
                            $data = !empty($result) ? $result->getResultArray() : [];
                            if(empty($data)) {
                                return "Sorry! {$column} detail could not be found";
                            }
                        }
                    }
                }
            }

            return $param;

        } catch(\Exception $e) {
            return [];
        }

    }

    /**
     * Permission Handler
     * 
     * @param String    $section
     * @param String    $permission
     * @param Array     $user
     * 
     * @return Mixed
     */
    public function permission_handler($section = null, $role = null, $user = []) {

		// if the user permission key is empty then try to regenerate it
		if(empty($section) || empty($role) || empty($user)) {
			return false;
		}

		// set the user permissions
		$permission_list = $user['metadata']['permissions'] ?? [];

		// if the permissions list is empty 
		if(empty($permission_list)) {
			// use the user_id obtained from session to get the user permissions
			return false;
		}

        // confirm that the requested page exists
        if(!isset($permission_list[$section])) {
            return false;
        }

        // confirm that the role exists
        if(!isset($permission_list[$section][$role])) {
            return false;
        }
        
        return 1;

    }
    
}
