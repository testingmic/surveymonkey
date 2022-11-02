<?php 
namespace App\Controllers;

class Surveys extends AppController {

    private $invalid_question = 'Sorry! The question id parsed could not be found in this survey.';

    /**
     * Embed the Survey Question
     * 
     * @param String    $slug
     * 
     * @return Mixed
     */
    public function embed($slug = null, $request = null) {

        if( empty($slug) ) {
            return $this->show_display('not_found');
        }

        $param = ['slug' => $slug, 'append_questions' => true];

        // get the clients and web statistics list
        $data['survey'] = $this->api_lookup('GET', 'surveys', $param)[0] ?? [];

        if(empty($data['survey'])) {
            return $this->show_display('not_found');
        }

        // set the title
        $data['pagetitle'] = $data['survey']['title'];
        $data['survey']['settings'] = json_decode($data['survey']['settings'], true);

        if( !empty($data['survey']['questions']) ) {
            $questions = [];
            foreach($data['survey']['questions'] as $question) {
                $questions[$question['id']] = $question;
            }
            $data['survey']['questions'] = $questions;
        }

        $isResult = (bool) ($request == "results");
        
        $data['votersGUID'] = [];
        $data['surveySlug'] = $slug;
        $data['isResult'] = $isResult;

        // if the request is not equal to results
        if(!$isResult) {

            // force refresh
            if( !empty($this->sessObject->forceRefresh) ) {
                $this->sessObject->remove(['surveyAnswers', 'initSurvey', 'firstQuestion', 'nextQuestion', 'forceRefresh']);
            }

            // next question
            $data['isContinue'] = (bool) !empty($this->sessObject->nextQuestion);

            // save the question slug in session
            $this->sessObject->set([
                'surveyId' => $data['survey']['id'], 
                'surveySlug' => $slug, 
                'surveyQuestions' => $data['survey']
            ]);

            // allow multiple voting
            $data['multipleVoting'] = (bool) !empty($data['survey']['settings']['allow_multiple_voting']) ? "Yes" : "No";
            $users = !empty($data['survey']['users_logs']) ? json_decode($data['survey']['users_logs'], true) : [];
            $data['votersGUID'] = !empty($users) ? array_column($users, 'guid') : [];
            $data['ip_address'] = $this->request->getIPAddress();

        }

        // display the page
        return $this->show_display('embed', $data);
    }

    /**
     * Prepare and return the survey results
     * 
     * @return Array
     */
    public function results() {

        $slug = $this->request->getGet('survey_slug');

        if(empty($slug)) {
            return $this->error($this->not_found_text());
        }

        $param = ['slug' => $slug, 'append_questions' => true, 'append_votes' => true];

        // get the clients and web statistics list
        $survey = $this->api_lookup('GET', 'surveys', $param)[0] ?? [];

        // return the results
        if(empty($survey)) {
            return $this->error($this->not_found_text());
        }

        $result = [];
        $result['summary']['votes_count'] = (int) $survey['submitted_answers'];
        $result['summary']['questions_count'] = count($survey['questions']);

        function regroup_keys($array = []) {
            if( empty($array) ) {
                return [];
            }

            foreach($array as $key => $value) {
                $data[$key + 1] = $value;
            }

            return $data ?? [];
        }

        $quest = [];
        foreach($survey['questions'] as $question) {
            $quest[$question['id']] = [
                'title' => $question['title'],
                'type' => $question['answer_type'],
                'options' => regroup_keys(json_decode($question['options'], true))
            ];
            $question_id = (int) $question['id'];
            $quest[$question['id']]['answers'] = array_filter($survey['votes'], function($votes) use($question_id) {
                if((int) $votes['question_id'] == $question_id) {
                    return true;
                }
                return false;
            });
        }

        function combine_array($array_keys = [], $array_values = [], $total) {
            $combine = [];
            foreach($array_keys as $key => $value) {
                
                $count = $array_values[$key] ?? 0;
                $combine[$value]['count'] = $count;
                $combine[$value]['percentage'] = empty($count) ? 0 : (round(($count / $total) * 100, 2));
            }
            return $combine;
        }

        $questions = [];
        $votes_count = $result['summary']['votes_count'];
        foreach($quest as $id => $item) {
            $ikey = array_key_first($item['answers']);
            $item['counts'] = json_decode($item['answers'][$ikey]['votes'], true);
            $item['grouping'] = combine_array($item['options'], $item['counts'], $votes_count);
            $item['votes_cast'] = array_sum(array_column($item['grouping'], 'count'));

            if($item['votes_cast'] !== $votes_count) {
                $skipped = $votes_count - $item['votes_cast'];
                $item['grouping']['skipped'] = [
                    'count' => $skipped,
                    'percentage' => empty($skipped) ? 0 : (round(($skipped / $votes_count) * 100, 2))
                ];
            }

            unset($item['counts']);
            unset($item['answers']);

            $questions[$id] = $item;
        }

        $result['questions'] = $questions;
        
        return $this->error($result);

    }

    /**
     * Display the Question
     * 
     * @param 
     * 
     * @return Array
     */
    public function question() {

        $params = array_map('esc', $this->request->getPost());

        if(empty($this->sessObject->surveyId)) {
            return $this->error($this->not_found_text());
        }

        // refresh the polls
        if( !empty($params['refresh_poll']) ) {
            // remove the session variables
            $this->sessObject->remove(['surveyAnswers', 'firstQuestion', 'nextQuestion']);
            $this->sessObject->set(['initSurvey' => true]);
            return 'Survey successfully refreshed';
        }

        $theSurvey = $this->sessObject->surveyQuestions;
        $theAnswers = !empty($this->sessObject->surveyAnswers) ? $this->sessObject->surveyAnswers : [];

        // if the request is to initialize the survey
        if( !empty($this->sessObject->initSurvey) ) {

            $initialize = !empty($theSurvey['cover_art']) ? '<div class="fluid-image">
                <img src="'.config('App')->baseURL . $theSurvey['cover_art'].'" alt=""></div>' : null;

            $initialize .= '<div>'.$theSurvey['description'].'</div>';

            $this->sessObject->remove('initSurvey');

            // return the response
            return $this->api_response([
                'code' => 200, 
                'result' => $initialize, 
                'additional' => [
                    'button_text' => $theSurvey['button_text']
                ]
            ]);

        }

        if(empty($theSurvey)) {
            return $this->error($this->not_found_text());
        }

        // end query if no question was found
        if(empty($theSurvey['questions'])) {
            return $this->error('Sorry! There are no questions to answer in this survey.');
        }

        // save the answer if the question id was parsed
        if( !empty($params['question_id']) ) {

            // get the question
            $quest = $theSurvey['questions'][$params['question_id']] ?? [];
            
            if(empty($quest)) {
                return $this->error($this->invalid_question);
            }

            $choice_id = $params['choice_id'] ?? null;

            // confirm if the question requires an answer
            if(!empty($quest['is_required']) && is_null($choice_id)) {
                return $this->error('This question requires an answer.');
            }

            // options
            $options = !empty($quest['options']) ? json_decode($quest['options'], true) : [];

            if( mb_strlen($choice_id) > 0 ) {
                if(!isset($options[($choice_id-1)])) {
                    return $this->error('The selected option is not valid.');
                }
            }

            // get answers
            $theAnswers[$params['question_id']] = [
                'question' => $params['question_id'],
                'choice' => $params['choice_id']
            ];

            // save the answer
            $this->sessObject->set('surveyAnswers', $theAnswers);
            
            // get the last question
            $lastQuestion = array_key_last($theSurvey['questions']);

            if( empty($this->sessObject->firstQuestion) ) {
                $firstQuestion = array_key_first($theSurvey['questions']);
                $this->sessObject->set('firstQuestion', "{$firstQuestion}_found");
            }

            if($lastQuestion == $params['question_id']) {
                $this->sessObject->set('nextQuestion', 'final');
            } else {
                $question_key = array_column_key($theSurvey['questions'], $params['question_id'], 'id');
                $this->sessObject->set('nextQuestion', ($question_key + 1));
            }

        }

        // set the question id
        $questionId = empty($this->sessObject->firstQuestion) ? array_key_first($theSurvey['questions']) : $this->sessObject->nextQuestion;

        // calculate the percentage
        $questions = $theSurvey['questions'];
        $theQuestion = $questions[$questionId] ?? [];

        if(($questionId !== 'final') && empty($theQuestion)) {
            return $this->error($this->invalid_question);
        }

        /**
         * Get the question answer
         * 
         * @param   Int     $questionId
         * @param   Array   $theAnswers
         * 
         * @return String
         */
        function selected_answer($questionId = null, $theAnswers = []) {
            if(is_null($theAnswers) || empty($questionId) || !is_array($theAnswers)) {
                return null;
            }

            foreach($theAnswers as $answer) {
                if($answer['question'] == $questionId) {
                    return $answer['choice'];
                }
            }

            return null;
        }

        /**
         * Format the question to be displayed
         * 
         * @param Array     $question
         * 
         * @return Array 
         */
        function format_question($question, $answer = null) {
            
            $questionOption = !empty($question['options']) ? json_decode($question['options'], true) : [];

            $html = "
            <div class='questionnaire mt-3'>
                <div class='question'>
                    <div class='select-notice'></div>
                    <div class='label-question mt-1'>
                        ".(!empty($question['is_required']) ? "<span class='required'>*</span>" : null)."
                        <span class='question-title'>{$question['title']}</span>
                    </div>
                    <div class='choices'>";

                    foreach($questionOption as $key => $option) { 
                        
                        $key++;
                        $html .= "
                        <div class='single-choice'>
                            <label class='choice choice-{$key}' for='form_choice_id{$key}'>
                                <input ".(!is_null($answer) && ($answer == $key) ? "checked" : null)." class='styled' type='radio' value='{$key}' name='question[choice_id]' id='form_choice_id{$key}' />
                                <label for='form_choice_id{$key}'>
                                    <p>{$option}</p>
                                </label>
                            </label>
                        </div>";

                    }

                $html .= "
                    <input type='hidden' hidden name='question[questionId]' value='{$question['id']}' readonly>
                    <input type='hidden' hidden name='is_required' value='{$question['is_required']}' readonly>
                    </div>
                </div>
            </div>";
            
            return $html;
        }

        // get the user agent
        $userAgent = $this->request->getUserAgent();
            
        // set the user agent
        $user_agent = $userAgent->__toString();
        $ip_address = $this->request->getIPAddress();

        $additional = [];

        if( ($questionId !== 'final') ) {

            $question = format_question($theQuestion, selected_answer($questionId, $theAnswers));

            $questionsCount = count($questions);
            $answersCount = empty($theAnswers) ? 1 : count($theAnswers) + 1;

            $percentage = round(($answersCount / $questionsCount) * 100);

            $additional['percentage'] = '
            <div class="progress-bar-container mt-0">
                <div class="progress-bar mt-1">
                    <div class="progress-bar-completed" style="width: '.$percentage.'%;"></div>
                </div>
                <div class="progress-bar-percentage">'.$percentage.'% completed</div>
            </div>
            <div class="useripaddress hidden text-center" hidden>
                '.$ip_address.'
            </div>';

            $additional['can_skip'] = !empty($theQuestion['is_required']) ? "No" : "Yes";

            $additional['button_text'] = "Continue";

        } else {

            // save the user responses into the database
            $votesObject = new \App\Controllers\v1\SurveysController();
            $vote = $votesObject->castvotes([
                'survey_id' => $this->sessObject->surveyId, 
                'votes' => $theAnswers,
                'guid' => $params['guid'] .'_'. $ip_address,
            ]);

            // if not successful
            if( !isset($vote['status'])) {
                return $vote;
            }

            $multipleVoting = (bool) !empty($theSurvey['settings']['allow_multiple_voting']);

            $question = "
            <div class='questionnaire mt-3'>
                <div class='question text-center'>
                    {$theSurvey['settings']['thank_you_text']}
                </div>
            </div>";
            $additional['percentage'] = "";
            $additional['guids'] = $vote['guid'];
            $additional['button_id'] = "poll-refresh";
            $additional['button_text'] = $multipleVoting ? "<i class='fa fa-dice-d6'></i> Cast Another Vote" : "<i class='fa fa-compress-arrows-alt'></i> Complete";

            $this->sessObject->remove('firstQuestion');
            $this->sessObject->set(['forceRefresh' => true, 'initSurvey' => true]);

        }

        // return the response
        return $this->api_response(['code' => 200, 'result' => $question, 'additional' => $additional]);

    }

}
?>