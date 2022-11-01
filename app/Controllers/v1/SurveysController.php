<?php
namespace App\Controllers\v1;

use App\Controllers\AccessBridge;
use App\Models\v1\SurveyModel;

class SurveysController extends AccessBridge {

    public $db_model;
    private $db_offset = 0;

    // reset the query limit and offsets
    private $qr_limit;
    private $qr_offset;
    
    // tables list
    private $item_table = 'surveys';

    public function __construct($parameters = []) {
        $this->db_model = new SurveyModel;
        $this->parameters = $parameters;
        $this->route = 'surveys';
    }

    /**
     * Return all available requests for the endpoint with its accepted parameters
     * 
     * @return Array
     */
    public function index() {

        $endpoints = [];

        if( is_array($this->endpoint) ) {
            foreach($this->endpoint as $key => $value) {
                $endpoints["{$this->route}/{$key}"] = $value;
            }
        }

        return [
            'enpoints' => $endpoints
        ];
    }

    /**
     * Set the Limit and Offset Parameters
     * If the user submitted a limit then it will be applied. However, if the set limit is greater than the 
     * default value then it will be reset to the default
     * 
     * @return Mixed
     */
    private function limit_offset($params) {

        // apply the limit
        $params['_limit'] = $params['_limit'] ?? ($params['limit'] ?? $this->db_limit);
        $limit = (int) $params['_limit'];

        // set the offset
        $this->qr_limit = !empty($this->qr_limit) ? $this->qr_limit : ($limit > $this->db_limit ? $this->db_limit : $limit);

        // apply the offset
        $this->qr_offset = isset($params['offset']) ? (int) $params['offset'] : $this->db_offset;
    }

    /**
     * Get the list of all classes
     * 
     * The default to to load all records. However, when the primary_key is set then a single record is returned
     * The limit and offset filters are applied. The default limit is 100
     * 
     * @param Array     $params
     * @param Int       $primary_key
     * 
     * @return Array
     */
    public function list(array $params = [], $primary_key = null) {
        
        try {

            // apply the limit
            $this->limit_offset($params);

            // set the builder
            $builder = $this->db_model->db
                        ->table("{$this->item_table} a")
                        ->select("a.*");

            // filter where in
            $whereInArray = $this->filterWhereIn($params, $this->route);

            // loop through the filter in array list
            foreach($whereInArray as $key => $whereIn) {
                $builder->whereIn($key, $whereIn);
            }

            // if the primary key is set
            if(!empty($primary_key)) {
                $this->qr_limit = 1;
                $builder->where('a.id', $primary_key);
            }

            // remove the deleted record
            $builder->whereNotIn('a.status', ['0']);

            // apply limit and offsets
            $builder->limit($this->qr_limit, $this->qr_offset);

            // get the data
            $result = $builder->get();

            $data = !empty($result) ? $result->getResultArray() : [];

            // if the loaddata was parsed and the primary key is not empty
            if( !empty($primary_key) || !empty($params['append_questions'])) {
                // convert the item into an array
                $n_data = [];
                foreach($data as $key => $item) {
                    $item['questions'] = $this->db_model->db->table('surveys_questions')
                                                    ->where([
                                                        'survey_id' => $item['id'], 'client_id' => $item['client_id'], 
                                                        'status !=' => '0'
                                                    ])->limit(200)->get()->getResultArray();
                    $n_data[] = $item;
                }
                $data = $n_data;
            }

            return $data;

        } catch(\Exception $e) {
            return [];
        }

    }

}