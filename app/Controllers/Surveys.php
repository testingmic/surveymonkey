<?php 
namespace App\Controllers;

class Surveys extends AppController {

    public function embed($slug = null) {

        if( empty($slug) ) {
            return $this->show_display('not_found');
        }

    }
}
?>