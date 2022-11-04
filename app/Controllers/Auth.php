<?php
namespace App\Controllers;

use App\Controllers\AppController;

class Auth extends AppController {

    /**
     * Log the user out of the system
     * 
     * @return Bool
     */
    public function logout() {
        
        // remove all sessions
        $this->session->remove(['_clientId', '_userId', '_userGroup', '_userApiToken', '_userData']);

        // destroy all sessions
        $this->session->destroy();

        return $this->api_response("POST", "auth", [
            'code' => 200,
            'result' => 'Logout successful'
        ]);
        
    }

}
