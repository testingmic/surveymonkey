<?php
include_once 'headtags.php';
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
        <div class="row">

        </div>
    </div>
</div>
<?php include_once 'foottags.php'; ?>