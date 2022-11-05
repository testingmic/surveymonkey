<?php 
namespace App\Filters;

use CodeIgniter\Filters\FilterInterface;
use CodeIgniter\HTTP\RequestInterface;
use CodeIgniter\HTTP\ResponseInterface;
use Config\Services;

class Throttle implements FilterInterface {

    public function before(RequestInterface $request, $arguments = null) {
        
        $throttler = Services::throttler();

        /**
         * Total of 1200 requests per minute
         * 
         * That is 20 requests per second from a particular IP Address
         */
        if($throttler->check(md5($request->getIPAddress()), 1200, MINUTE) === false) {
            return Services::response()->setStatusCode(429);
        }

    }

    public function after(RequestInterface $request, ResponseInterface $response, $arguments = null) {

    }

}
?>