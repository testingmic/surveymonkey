<?php
namespace App\Models\v1;

use CodeIgniter\Model;

class UsersModel extends Model {

    protected $table = 'users';
    protected $primaryKey = 'id';
    protected $allowedFields = [
        'name', 'school_id', 'username', 'email', 'recovercontact',
        'index_number', 'password', 'group_id', 'programme_id', 
        'class_id', 'status', 'created_by', 'is_bulk_record'
    ];

    public function create($data) {
        
        $this->insert($data);

        return $this->getInsertID();

    }

    public function change($user_id, $data) {

        return $this->update($user_id, $data);

    }

    public function status($user_id, $status) {
        
        return $this->update($user_id, $status);

    }

    public function remove($user_id) {
        
        return $this->update($user_id, ['status' => '0']);

    }

}
?>