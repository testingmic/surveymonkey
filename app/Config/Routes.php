<?php

namespace Config;

// Create a new instance of our RouteCollection class.
$routes = Services::routes();

// Load the system's routing file first, so that the app and ENVIRONMENT
// can override as needed.
if (file_exists(SYSTEMPATH . 'Config/Routes.php')) {
    require SYSTEMPATH . 'Config/Routes.php';
}

/*
 * --------------------------------------------------------------------
 * Router Setup
 * --------------------------------------------------------------------
 */
$routes->setDefaultNamespace('App\Controllers');
$routes->setDefaultController('Home');
$routes->setDefaultMethod('index');
$routes->setTranslateURIDashes(false);
$routes->set404Override('\App\Controllers\Home::not_found');
$routes->setAutoRoute(false);

/*
 * --------------------------------------------------------------------
 * Route Definitions
 * --------------------------------------------------------------------
 */

// We get a performance increase by specifying the default
// route since we don't have to scan directories.
$routes->get('/', 'Home::index');
$routes->get('/embed', 'Surveys::embed');
$routes->get('/dashboard', 'Home::index');
$routes->post('/surveys/save', 'Surveys::save');
$routes->get('/embed/(:any)', 'Surveys::embed/$1/$2');

$routes->get('/surveys/results(:any)', 'Surveys::results');
$routes->post('/surveys/show_question', 'Surveys::question');
$routes->post('/surveys/savequestion', 'Surveys::savequestion');
$routes->get('/surveys/modify/(:any)', 'Surveys::modify/$1/$2/$3');
$routes->post('/surveys/deletequestion/(:num)', 'Surveys::deletequestion/$1');
$routes->get('/surveys/loadquestion/(:any)', 'Surveys::loadquestion/$1/$2');
$routes->post('/surveys/savefingerprint/(:any)', 'Surveys::savefingerprint/$1');


$routes->post('/auth/logout', 'Auth::logout');


// command line commands
$routes->cli('root/(:any)', 'Crontab::jobs/$1');

// request to api routing
$routes->match(['put', 'delete', 'get', 'post'], '/api(:any)', 'Api::index/$1/$2/$3');

/*
 * --------------------------------------------------------------------
 * Additional Routing
 * --------------------------------------------------------------------
 *
 * There will often be times that you need additional routing and you
 * need it to be able to override any defaults in this file. Environment
 * based routes is one such time. require() additional route files here
 * to make that happen.
 *
 * You will have access to the $routes object within that file without
 * needing to reload it.
 */
if (file_exists(APPPATH . 'Config/' . ENVIRONMENT . '/Routes.php')) {
    require APPPATH . 'Config/' . ENVIRONMENT . '/Routes.php';
}
