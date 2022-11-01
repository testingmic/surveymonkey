<?php 
namespace App\Controllers;

class Surveys extends AppController {

    /**
     * Embed the Survey Question
     * 
     * @param String    $slug
     * 
     * @return Mixed
     */
    public function embed($slug = null) {

        if( empty($slug) ) {
            return $this->show_display('not_found');
        }

        // get the clients and web statistics list
        $data['survey'] = $this->api_lookup('GET', 'surveys', ['slug' => $slug, 'append_questions' => true])[0] ?? [];

        if(empty($data['survey'])) {
            return $this->show_display('not_found');
        }

        // set the title
        $data['pagetitle'] = $data['survey']['title'];
        $data['survey']['settings'] = json_decode($data['survey']['settings'], true);

        // save the question slug in session
        $this->sessObject->set(['surveyId' => $slug, 'surveyQuestions' => $data['survey']]);

        // display the page
        return $this->show_display('embed', $data);
    }

    /**
     * Display the Question
     * 
     * @param 
     * 
     * @return Array
     */
    public function question() {

        if(empty($this->sessObject->surveyId)) {
            return $this->error($this->not_found_text());
        }

        $questions = $this->sessObject->surveyQuestions;

        if(empty($questions)) {
            return $this->error($this->not_found_text());
        }

        if(empty($questions['questions'])) {
            return $this->error('Sorry! There are no questions to answer in this survey.');
        }

        // set the question id
        $questionId = empty($this->sessObject->firstQuestion) ? 0 : $this->sessObject->nextQuestion;

        // calculate the percentage
        $questions = $questions['questions'];
        $theQuestion = $questions[$questionId] ?? [];

        if(($questionId !== 'final') && empty($theQuestion)) {
            return $this->error('Sorry! The question id parsed could not be found in this survey.');
        }

        /**
         * Format the question to be displayed
         * 
         * @param Array     $question
         * 
         * @return Array 
         */
        function format_question($question) {
            
            $questionOption = !empty($question['options']) ? json_decode($question['options'], true) : [];

            $html = "
            <div class='questionnaire'>
                <div class='question'>
                    <div class='select-notice'></div>
                    <div class='label-question mt-1'>
                        ".(!empty($question['is_required']) ? "<span class='required'>*</span>" : null)."
                        <span class='question-title'>{$question['title']}</span>
                    </div>
                    <div class='choices'>";

                    foreach($questionOption as $key => $option) { 
                        $html .= "
                        <div class='single-choice'>
                            <label class='choice choice-{$key}' for='form_choice_id{$key}'>
                                <input class='styled' type='radio' value='{$key}' name='question[choice_id]' id='form_choice_id{$key}' />
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

        $question = format_question($theQuestion);

        // return the response
        return $this->api_response(['code' => 200, 'result' => $question]);

    }
}
?>