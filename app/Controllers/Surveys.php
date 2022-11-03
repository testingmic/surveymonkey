<?php 
namespace App\Controllers;

class Surveys extends AppController {

    private $invalid_question = 'Sorry! The question id parsed could not be found in this survey.';

    /**
     * Create and Modify an Existing survey
     * 
     * @param String        $slug
     * @param String        $request
     * 
     */
    public function modify($slug = null, $request = null) {

        $data = [];
        $data['isFound'] = false;
        $data['manageSurvey'] = true;
        $data['slug'] = null;
        $file = 'survey';

        if( $slug == 'add') {
            $data['pagetitle'] = "New Survey";
        }

        elseif(in_array($request, ['edit', 'questions'])) {

            // get the survey
            $param = ['slug' => $slug, 'append_questions' => true];

            // get the clients and web statistics list
            $survey = $this->api_lookup('GET', 'surveys', $param)[0] ?? [];

            // return the results
            if(empty($survey)) {
                return $this->show_display('not_found');
            }

            if($request == 'questions') {
                $file = 'questions';
            }

            $data['survey'] = $survey;
            $data['slug'] = $slug;
            $data['pagetitle'] = $data['survey']['title'];
            $data['survey']['settings'] = json_decode($data['survey']['settings'], true);
            $data['isFound'] = true;
        }

        return $this->show_display($file, $data);
    }

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

        } else {
            $data['manageSurvey'] = true;
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
                $combine[$value]['percentage'] = empty($count) ? 0 : (round(($count / $total) * 100));
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
                    'percentage' => empty($skipped) ? 0 : (round(($skipped / $votes_count) * 100))
                ];
            }

            unset($item['counts']);
            unset($item['answers']);

            $questions[$id] = $item;
        }

        $result['questions'] = $questions;
        $result['first_question'] = array_key_first($questions);
        
        return $this->api_response(['code' => 200, 'result' => $result]);

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
                
                foreach($theSurvey['questions'] as $id => $data) {
                    if($id > $question_key) {
                        $this->sessObject->set('nextQuestion', $id);
                        break;
                    }
                }
                
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
                'guid' => $params['guid'],
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

    /**
     * Load Question
     * 
     * @param String    $slug
     * @param Int       $question_id
     * 
     * @return Array
     */
    public function loadquestion($slug = null, $question_id = null) {

        $param = ['slug' => $slug, 'append_questions' => true];
        $survey = $this->api_lookup('GET', 'surveys', $param)[0] ?? [];

        if( empty($survey) ) {
            return $this->error($this->not_found_text());
        }

        $question = [];
        if( !empty($question_id) ) {
            $question = array_filter($survey['questions'], function($quest) use($question_id) {
                if($quest['id'] == $question_id) {
                    return true;
                }
                return false;
            });
            
            if( empty($question) ) {
                return $this->error($this->not_found_text("question"));
            }

            $key = array_key_first($question);
            $question[$key]['options'] = json_decode($question[$key]['options'], true);

            $question = $question[$key];
        }

        $quid = $question_id;
        if( empty($question) && empty($question_id) ) {
            $question['options'] = [0, 1];
            $quid = "new_question";
        }

        $form = '
        <form method="POST" action="'.config('App')->baseURL.'surveys/savequestion" class="questionForm">
            <div class="bg-light p-3 position-relative">
                '.form_overlay().'
                <div class="form-group mb-2">
                    <label for="">Question</label>
                    <input value="'.($question['title'] ?? null).'" type="text" name="title" id="title" class="form-control">
                </div>
                <div class="form-group">
                    '.(!empty($question['instructions']) ? null : '<span onclick="return add_instruction()" class="text-primary instruction cursor">+ add instructions</span>').'
                    <input type="text" value="'.($question['instructions'] ?? null).'" name="instructions" id="instructions" class="'.(!empty($question['instructions']) ? null : 'hidden').' form-control">
                </div>
                <div class="form-group mb-3 mt-3">
                    <label for="">Question Type</label>
                    <select name="answer_type" id="answer_type" class="selectpicker form-control">
                        <option value="multiple">Multiple Choice</option>
                    </select>
                </div>
                <div class="question-option">
                    <label for="">Options</label>
                    <div class="option-container" id="question_id_'.$quid.'">';
                    if(!empty($question['options'])) {
                        foreach($question['options'] as $key => $option) {
                            $key++;
                            $option = !empty($question_id) ? $option : null;
                            $form .= '
                            <div class="form-group mb-2" data-question="'.$quid.'" data-option_id="'.$key.'">
                                <div class="d-flex justify-content-between">
                                    <div class="col-11">
                                        <input type="text" value="'.$option.'" name="option['.$key.']" id="option['.$key.']" class="form-control">
                                    </div>
                                    <div>
                                        <button type="button" onclick="return remove_option(\''.$key.'\')" class="btn btn-outline-danger btn-sm">
                                            <i class="fa fa-times-circle"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>';
                        }
                    }

            $form .=  '
                    </div>
                    <span class="text-primary cursor" onclick="return add_option('.$question_id.')">+ add option</span>
                </div>
                <div class="form-group mt-2">
                    <label for="is_required" class="cursor">
                        <input type="checkbox" '.(!empty($question['is_required']) ? "checked" : null).' name="is_required" id="is_required">
                        Required question
                    </label>
                </div>
                <div class="form-group mt-3">
                    <input readonly type="hidden" name="question_id" value="'.$question_id.'">
                    <input readonly type="hidden" name="survey_id" value="'.$survey['id'].'">
                    <button class="btn btn-success min-100 pr-5" type="submit">Save</button>
                    <span class="text-primary cursor" onclick="return cancel_update()">Cancel</span>
                </div>
            </div>
        </form';

        return $this->api_response(['result' => $form, 'code' => 200]);
        
    }

    /**
     * Save Question
     * 
     * @return Array
     */
    public function savequestion() {

        $method = "POST";
        $endpoint = "surveys/createquestion";

        $params = array_map('esc', $this->request->getPost());

        if( empty($params['title'])) {
            return $this->error("The title is required.");
        }
        
        if( empty($params['survey_id'])) {
            return $this->error("The survey id is required.");
        }
        
        $param['title'] = clean_text($params['title']);

        if( isset($params['instructions']) ) {
            $param['instructions'] = clean_text($params['instructions']);
        }

        if( !empty($params['answer_type']) ) {
            $param['answer_type'] = clean_text($params['answer_type']);
        }

        if( !empty($params['survey_id']) ) {
            $param['survey_id'] = clean_text($params['survey_id']);
        }

        if( !empty($params['question_id']) ) {
            $param['question_id'] = clean_text($params['question_id']);
        }

        $param['is_required'] = isset($params['is_required']) ? 1 : 0;

        if( !empty($params['option']) ) {
            if(!is_array($params['option'])) {
                return $this->error("The option must be an array");
            }
            
            $options = [];
            foreach($params['option'] as $key) {
                $options[] = clean_text($key);
            }
            $param['options'] = json_encode($options);
        }

        if( preg_match("/^[0-9]+$/", $params['question_id']) ) {
            $method = "PUT";
            $endpoint = "surveys/updatequestion/{$params['question_id']}";
        } else {
            $params['question_id'] = null;
        }

        $request = $this->api_lookup($method, $endpoint, $param);

        if(isset($request['code']) && $request['code'] == 200) {
            $request['additional']['question'] = format_question($request['result'], null, $request['result']['slug'], false);
        }
        $request['additional']['route'] = "questions";

        return $this->api_response($request, $method, "surveys");

    }

    /**
     * Delete Question
     * 
     * @param Int       $question_id
     * 
     * @return Array
     */
    public function deletequestion($question_id) {

        $request = $this->api_lookup("DELETE", "surveys/deletequestion", ['question_id' => $question_id]);

        return $this->api_response($request, "DELETE", "question");
        
    }

    /**
     * Save Survey
     * 
     * @param Array     $this->request->getPost()
     * 
     * @return Array
     */
    public function save() {
        
        $method = "POST";
        $endpoint = "surveys";
        $params = array_map('esc', $this->request->getPost());

        foreach(['title', 'description', 'button_text'] as $item) {
            if(empty($params[$item])) {
                return $this->error("Sorry the {$item} is required.");
            }
            $param[$item] = clean_text($params[$item]);
        }

        if(!empty($params['settings'])) {
            if(!is_array($params['settings'])) {
                return $this->error("Sorry! The settings must be an array");
            }
            $accepted = [
                'display_images', 'publicize_result', 'receive_statistics',
                'allow_multiple_voting', 'paginate_question', 'allow_skip_question', 
                'thank_you_text', 'closed_survey_text', 'footer_text'
            ];

            foreach($params['settings'] as $key => $value) {
                if(!in_array($key, $accepted)) {
                    return $this->error("Sorry the {$key} variable is not accepted.");
                }
                $param['settings'][$key] = clean_text($value);
            }

            $param['settings'] = json_encode($param['settings']);
        }

        if(isset($params['start_date'])) {
            if(valid_date($params['start_date'])) {
                $param['start_date'] = date("Y-m-d H:i:s", strtotime($params['start_date']));
            } else {
                $param['start_date'] = null;
            }
        }

        if(isset($params['end_date'])) {
            if(valid_date($params['end_date'])) {
                $param['end_date'] = date("Y-m-d H:i:s", strtotime($params['end_date']));
            } else {
                $param['end_date'] = null;
            }
        }

        foreach(['slug', 'is_published', 'cover_art'] as $item) {
            if(isset($params[$item])) {
                $param[$item] = clean_text($params[$item]);
            }
        }

        if(!empty($params['survey_id'])) {
            $method = "PUT";
            $endpoint = "surveys/{$params['survey_id']}";
        }

        $request = $this->api_lookup($method, $endpoint, $param);
        
        return $this->api_response($request, $method, 'surveys');

    }

}
?>