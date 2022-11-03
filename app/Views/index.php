<?php
include_once 'headtags.php';
?>
<div class="survey-container">
    <div class="survey-header">
        <div class="container">
            <?= $AppName ?>
        </div>
    </div>
    <div class="container pt-4">
        <div class="d-flex justify-content-between">
            <div></div>
            <div>
                <?php if(hasPermission("surveys", "add", $metadata)) { ?>
                    <a class="btn btn-outline-primary btn-sm" href="<?= $baseURL ?>surveys/modify/add">
                        <i class="fa fa-place-of-worship"></i> New Survey
                    </a>
                <?php } ?>
            </div>
        </div>
        <div class="row mt-3">
            <?php foreach($surveys_list as $survey) { ?>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-header">
                            <?= $survey['title'] ?>
                        </div>
                        <div class="card-body bg-white">
                            <div class="survey-image">
                                <img class="m-0" width="100%" src="<?= $baseURL . $survey['cover_art'] ?>" alt="">
                            </div>
                            <div>
                                <?= character_limiter(strip_tags($survey['description']), 160) ?>
                            </div>
                            <div class="mt-2">
                                <small>
                                    <i class="fa fa-calendar-check"></i> <?= $survey['date_created'] ?>
                                </small>
                                <small>
                                    <i class="fa fa-chart-pie"></i> <?= $survey['submitted_answers'] ?> Participants
                                </small>
                            </div>
                        </div>
                        <div class="card-footer w-100">
                            <div class="w-100 d-flex justify-content-between">
                                <div>
                                    <?php if(hasPermission("surveys", "update", $metadata)) { ?>
                                    <a href="<?= $baseURL ?>surveys/modify/<?= $survey['slug'] ?>/edit" class="btn btn-sm btn-outline-success">
                                        <i class="fa fa-edit"></i> Edit
                                    </a>
                                    <?php } ?>
                                    <?php if(hasPermission("surveys", "delete", $metadata)) { ?>
                                    <button class="btn btn-sm btn-outline-danger">
                                        <i class="fa fa-trash"></i>
                                    </button>
                                    <?php } ?>
                                </div>
                                <div>
                                    <a target="_blank" href="<?= $baseURL ?>embed/<?= $survey['slug'] ?>/results" class="btn btn-sm btn-outline-warning">
                                        <i class="fa fa-chart-bar"></i> Results
                                    </a>
                                    <a target="_blank" href="<?= $baseURL ?>embed/<?= $survey['slug'] ?>" class="btn btn-sm btn-outline-primary">
                                        View
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            <?php } ?>
        </div>
    </div>
</div>
<?php include_once 'foottags.php'; ?>