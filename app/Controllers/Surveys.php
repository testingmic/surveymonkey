<?php 
namespace App\Controllers;

class Surveys extends AppController {

    public function embed($slug = null) {

        if( empty($slug) ) {
            return $this->show_display('not_found');
        }

        // get the clients and web statistics list
        $data['survey'] = $this->api_lookup('GET', 'surveys', ['slug' => $slug, 'append_questions' => true])[0] ?? [];

        if(empty($data['survey'])) {
            return $this->show_display('not_found');
        }

        $data['pagetitle'] = $data['survey']['title'];
        $data['survey']['settings'] = json_decode($data['survey']['settings'], true);

        // display the page
        return $this->show_display('embed', $data);
    }
}
?>