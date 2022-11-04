<?php
include_once 'headtags.php';
?>
<div class="survey-content">
    <?php if( !$isResult ) { ?>
        <div class="survey-body">
            <?php if (!empty($survey['cover_art'])) { ?>
                <div class="fluid-image">
                    <img src="<?= $baseURL . $survey['cover_art'] ?>" alt="">
                </div>
            <?php } ?>
            <div><?= $survey['description'] ?></div>
        </div>
        <div class="text-center mt-3">
            <button disabled id="poll-button" data-default="<?= $isContinue ? "Continue" : $survey['button_text'] ?>" class="btn btn-success begin-button">
                <?= $isContinue ? "Continue" : "Please wait <i class='fa fa-spin fa-spinner'></i>" ?>
            </button>
            <div class="mt-3 hidden" id="skipquestion">
                <span onclick="return skipped_question()" class="text-black text-decoration-underline cursor" title="Skip this question">
                    <small>Skip Category</small>
                </span>
            </div>
            <div class="percentage mt-2 pt-0"></div>
            <input type="hidden" disabled name="multipleVoting" value="<?= $multipleVoting ?>">
            <input type="hidden" disabled name="ipAddress" value="<?= $ip_address ?>">
            <input type="hidden" disabled name="hasSkipped" value="No">
            <input type="hidden" disabled name="proceed_to_load" value="continue">
        </div>
    <?php } else { ?>
        <input type="hidden" name="surveyAnalytic" data-survey_slug="<?= $survey['slug'] ?>" data-survey_id="<?= $survey['id'] ?>" disabled>
        <div class="container p-3 position-relative survey_analytic">
            <?= form_overlay() ?>
            <div class="row">
                <div class="col-md-9"><h5>Survey Report</h5></div>
                <div class="col-md-3">
                    <label for="">Select Question</label>
                    <select name="question_id" id="question_id" class="selectpicker form-control"></select>
                </div>
                <div class="col-lg-12 mt-3">
                    <div class="pt-2 mb-3" id="survey_question"></div>
                    <div class="border-top border-primary pt-2" id="answer_question"></div>
                </div>
            </div>
        </div>
    <?php } ?>
</div>
<script>var votersGUID = <?= json_encode($votersGUID) ?>;</script>
<?php include_once 'foottags.php'; ?>