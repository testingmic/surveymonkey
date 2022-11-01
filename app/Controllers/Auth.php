<?php
namespace App\Controllers;

use App\Controllers\AppController;

class Auth extends AppController {

    /**
     * Verifying user credentials
     * 
     * @param Int       $params['PIN']
     * @param Int       $params['client_id']
     * @param String    $params['index_number']
     * @param String    $params['reference_id']
     * 
     * @return Array
     */
    public function verify($request = [], $session = null) {

        $session = !empty($session) ? $session : session();

        // if the response is successful
        if(isset($request['access_token']) && isset($request['user'])) {
            $session->set([
                '_userName' => $request['user']['username'],
                '_schoolId' => $request['user']['client_id'],
                '_userId' => $request['user']['id'],
                '_userGroup' => ucfirst($request['user']['group_name']),
                '_userApiToken' => $request['access_token']
            ]);
            $session->remove(['_paymentReferenceId']);
            $request = [
                'code' => 200,
                'result' => 'Login was successful.',
                'additional' => [
                    'href' => 'account/dashboard'
                ]
            ];
        }

        // if the payment reference was parsed
        elseif(isset($request['paystack']['public_key']) && isset($request['school'])) {

            // set the email address
            $useremail = empty($request['email']) ? $request['paystack']['default_email'] : $request['email'];

            if($request['school']['status'] === 'closed') {
                $verb = "had";
                $append_html = '
                    <div class="mt-2">
                        However, the admission process has ended hence you may not be able to use the portal
                        to register. Kindly contact the school on <strong>'.$request['school']['contact'].'</strong>
                        for further clarification
                        <span onclick="return _cancel_payment()" class="text-primary underline cursor">
                            Reset Form
                        </span>
                    </div>
                </div>';
            } else {
                $verb = "have";
                $append_html = '
                    <div class="mt-2">
                        You are required to make payment of 
                        <strong class="text-danger underline font-16">
                            GHS '.number_format(($request['school']['amount']/100), 2).'
                        </strong>
                        to process your document online.
                    </div>
                    <div class="mt-2">
                        Click the proceed button below to make payment or 
                        <span onclick="return _cancel_payment()" class="text-primary underline cursor">Cancel</span>
                    </div>
                </div>
                <div>
                    <input maxlength="16" value="'.$request['school']['amount'].'" readonly type="hidden" required name="amount_to_pay" class="form-control" placeholder="Pay Amount">
                    <input readonly value="'.$request['paystack']['public_key'].'" type="hidden" required name="public_key">
                    <input readonly value="'.$useremail.'" type="hidden" required name="user_email">
                    <input readonly value="'.$request['paystack']['default_email'].'" type="hidden" required name="default_email">
                    <input readonly value="'.$request['paystack']['payment_reference'].'" type="hidden" required name="payment_reference">
                    <input readonly value="'.$request['paystack']['subaccount'].'" type="hidden" required name="pk_subaccount">
                </div>';
            }

            // set the reference id in session
            $session->set('_paymentReferenceId', $request['paystack']['payment_reference']);

            // set some hidden input fields
            $html_form = '
            <div class="text-center">
                <h4>Hello <span class="text-success">'.$request['firstname'].' '.$request['lastname'].',</span></h4>
                <div>
                    You '.$verb.' placement for
                    <div><strong class="text-primary font-18 text-uppercase">'.$request['school']['name'].'</strong></div>
                    to pursue a course in <strong class="text-primary font-18 text-uppercase">'.$request['programme_name'].'</strong>
                </div>';

            $html_form .= $append_html;

            $request = [
                'code' => 200,
                'result' => [
                    'proceed_to_payment' => $html_form,
                    'admissionstatus' => $request['school']['status']
                ]
            ];
        }

        return $request;

    }

    /**
     * Log the user out of the system
     * 
     * @return Bool
     */
    public function logout() {
        
        // remove all sessions
        $this->session->remove(['_schoolId', '_userId', '_userGroup', '_userApiToken', '_userData']);

        // destroy all sessions
        $this->session->destroy();

        return $this->api_response("POST", "auth", [
            'code' => 200,
            'result' => 'Logout successful'
        ]);
        
    }

}
