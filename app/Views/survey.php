<?php
include_once 'headtags.php';
$settings = [
    'display_images', 'publicize_result', 'receive_statistics',
    'allow_multiple_voting', 'paginate_question', 'allow_skip_question'
];
?>
<div class="survey-container">
    <div class="survey-header">
        <div class="container">
            <?= $AppName ?> - <?= $isFound ? "Modify Survey" : "Create Survey" ?>
        </div>
    </div>
    <div class="container pt-4">
        <div class="d-flex justify-content-between">
            <div></div>
            <div>
                <a class="btn btn-outline-primary btn-sm" href="<?= $baseURL ?>">
                    <i class="fa fa-list"></i> List Surveys
                </a>
                <?php if( !empty($isFound) ) { ?>
                    <a class="btn btn-sm btn-outline-success" href="<?= $baseURL ?>surveys/modify/add">
                        <i class="fa fa-place-of-worship"></i> New Survey 
                    </a>
                <?php } ?>
            </div>
        </div>
        <div class="row mb-4 pb-3">
            <div class="col-lg-12 mt-2">
                <form action="<?= $baseURL ?>surveys/save" class="appForm" method="POST">
                    <div class="card">
                        <div class="card-header">
                            <div class="d-flex justify-content-between w-100">
                                <div><span class="surveytitle">Configuration</span></div>
                                <div>
                                    <?php if(!empty($slug)) { ?>
                                    <a class="btn btn-secondary btn-sm" href="<?= $baseURL ?>surveys/modify/<?= !$isFound ? "add" : "{$slug}/edit" ?>/questions">
                                        Questions
                                    </a>
                                    <?php } ?>
                                </div>
                            </div>
                        </div>
                        <div class="card-body bg-white">
                            <div class="row">
                                <div class="col-md-12 border-bottom mb-3 border-primary">
                                    <h5 class="text-primary text-uppercase">Basic Information</h5>
                                </div>
                                <div class="col-md-9 mb-3">
                                    <label for="">Survey Title</label>
                                    <input type="text" name="title" class="form-control" value="<?= $survey['title'] ?? null ?>">
                                </div>
                                <div class="col-md-3 mb-3">
                                    <label for="">Is Published</label>
                                    <select class="form-control" name="is_published" id="is_published">
                                        <option <?= !empty($survey) && empty($survey['is_published']) ? "selected" : null; ?> value="0">No</option>
                                        <option <?= !empty($survey) && !empty($survey['is_published']) ? "selected" : null; ?> value="1">Yes</option>
                                    </select>
                                </div>
                                <div class="col-lg-12 mb-3">
                                    <label for="">Description</label>
                                    <trix-editor input='trix_input' class='trix-slim-scroll' id='description' name='description'></trix-editor>
                                    <input type='hidden' hidden id='trix_input' value='<?= isset($survey['description']) ? htmlentities($survey['description']) : null ?>'>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="">Thank You Text</label>
                                    <trix-editor input='thank_you_text' class='short-height trix-slim-scroll' id='thank_you' name='settings[thank_you_text]'></trix-editor>
                                    <input type='hidden' hidden id='thank_you_text' value='<?= !empty($survey) ? htmlentities($survey['settings']['thank_you_text']) : null ?>'>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="">Closed Survey</label>
                                    <trix-editor input='closed_survey_text' class='short-height trix-slim-scroll' id='closed_survey' name='settings[closed_survey_text]'></trix-editor>
                                    <input type='hidden' hidden id='closed_survey_text' value='<?= !empty($survey) ? htmlentities($survey['settings']['closed_survey_text']) : null ?>'>
                                </div>
                                <div class="col-md-12 mb-3">
                                    <label for="">Closed Survey</label>
                                    <trix-editor input='footer_text' class='short-height trix-slim-scroll' id='footer_info' name='settings[footer_text]'></trix-editor>
                                    <input type='hidden' hidden id='footer_text' value='<?= !empty($survey) ? htmlentities($survey['settings']['footer_text']) : null ?>'>
                                </div>
                                <div class="col-md-12 border-bottom mt-3 mb-3 border-primary">
                                    <h5 class="text-primary text-uppercase">Settings</h5>
                                </div>
                                <?php foreach($settings as $item) { ?>
                                    <div class="col-md-4 mb-3">
                                        <label for=""><?= ucwords(str_ireplace("_", " ", $item)); ?></label>
                                        <select name="settings[<?= $item ?>]" id="settings[<?= $item ?>]" class="form-control">
                                            <option <?= !empty($survey) && empty($survey['settings'][$item]) ? "selected" : null; ?> value="0">No</option>
                                            <option <?= !empty($survey) && !empty($survey['settings'][$item]) ? "selected" : null; ?> value="1">Yes</option>
                                        </select>
                                    </div>
                                <?php } ?>
                                <div class="col-md-12 border-bottom mt-3 mb-3 border-primary">
                                    <h5 class="text-primary text-uppercase">Schedule Survey</h5>
                                </div>
                                <div class="col-md-4">
                                    <label for="">Start Time</label>
                                    <input type="datetime-local" value="<?= $survey['start_date'] ?? null ?>" name="start_date" id="start_date" class="form-control">
                                </div>
                                <div class="col-md-4">
                                    <label for="">End Time</label>
                                    <input type="datetime-local" value="<?= $survey['end_date'] ?? null ?>" name="end_date" id="end_date" class="form-control">
                                </div>
                                <input type="hidden" readonly name="slug" value="<?= $slug ?>">
                                <input type="hidden" readonly name="survey_id" value="<?= $survey['id'] ?? null ?>">
                                <div class="col-md-12 text-center mt-4">
                                    <button class="btn min-150 btn-success" type="submit"><i class="fa fa-save"></i> Save</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<?php include_once 'foottags.php'; ?>