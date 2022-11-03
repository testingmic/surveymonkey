<?php

namespace App\Models\v1;

use CodeIgniter\Model;

class SurveyModel extends Model {
    
    protected $table = 'surveys';
    protected $primaryKey = 'id';
    protected $allowedFields = [
        'client_id', 'title', 'slug', 'description', 'end_date', 'is_published', 'button_text',
        'date_created', 'created_by', 'settings', 'start_date', 'status', 'cover_art'
    ];

    public function create($data) {
        
        $this->insert($data);

        return $this->getInsertID();

    }

    public function change($survey_id, $data) {

        return $this->update($survey_id, $data);

    }

    public function status($survey_id, $status) {
        
        return $this->update($survey_id, $status);

    }

    public function remove($survey_id) {
        
        return $this->update($survey_id, ['status' => '0']);

    }

}
?>