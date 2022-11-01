<?php

namespace App\Controllers;

use App\Controllers\AppController;

class Home extends AppController {

    public function index() {
        $data = [];

        // get list of all clients
        $this->generalApi = true;
        
        // get the clients and web statistics list
        $data['surveys_list'] = $this->api_lookup('GET', 'surveys') ?? [];
        
        try {
            return view('index', $data);
        } catch(\Exception $e) {
            return $e->getMessage();
        }
    }

    public function not_found() {
        return $this->show_display('not_found');
    }

}
