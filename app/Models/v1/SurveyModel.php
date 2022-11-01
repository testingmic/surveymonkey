<?php

namespace App\Models\v1;

use CodeIgniter\Model;

class SurveyModel extends Model {
    
    protected $table = 'surveys';
    protected $primaryKey = 'id';
    protected $allowedFields = ['title', 'slug', 'date_created', 'created_by'];

    public function create($data) {
        
        $this->insert($data);

        return $this->getInsertID();

    }

    public function change($class_id, $data) {

        return $this->update($class_id, $data);

    }

    public function status($class_id, $status) {
        
        return $this->update($class_id, $status);

    }

    public function remove($class_id) {
        
        return $this->update($class_id, ['status' => '0']);

    }

}
?>