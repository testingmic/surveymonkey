<?php
include_once 'headtags.php';
$settings = [
    'publicize_result', 'receive_statistics',
    'allow_multiple_voting', 'paginate_question', 'allow_skip_question'
];
$canEdit = hasPermission("questions", "add", $metadata);
$canDelete = hasPermission("questions", "add", $metadata);
?>
<div class="container pt-4" style="max-width:1000px;">
    <div class="d-flex justify-content-between">
        <div></div>
        <div>
            <a class="btn btn-outline-primary btn-sm" href="<?= $baseURL ?>">
                <i class="fa fa-list"></i> List Surveys
            </a>
            <?php if( !empty($isFound) && hasPermission("surveys", "update", $metadata)) { ?>
                <a class="btn btn-sm btn-outline-success" href="<?= $baseURL ?>surveys/modify/<?= $slug ?>/edit">
                    <i class="fa fa-cog"></i> Configuration
                </a>
            <?php } ?>
            <a class="btn btn-sm btn-primary" title="Dashboard" href="<?= $baseURL ?>">
                <i class="fa fa-home"></i>
            </a>
        </div>
    </div>
    <div class="alert alert-success mb-0 mt-2">
        Here you can edit your questions or add new ones.
    </div>
    <div class="row mb-4 pb-3">
        <div class="col-lg-12 mt-2">
            <div class="card">
                <div class="card-header">
                    <h3><?= $survey['title'] ?></h3>
                </div>
                <div class="card-body bg-white">
                    <?php if(isset($survey['questions'])) { ?>
                        <?php if(!empty($survey['questions']) && is_array($survey['questions'])) { ?>
                            <?php foreach($survey['questions'] as $question) { ?>
                                <div class="question-wrapper p-3">
                                    <?= format_question($question, null, $slug, true, ['canEdit' => $canEdit, 'canDelete' => $canDelete]); ?>
                                </div>
                            <?php } ?>
                        <?php } ?>
                    <?php } ?>
                    <div class="p-3">
                        <div class="new-question"></div>
                    </div>
                </div>
                <?php if(hasPermission("questions", "update", $metadata)) { ?>
                <div class="card-footer text-center w-100">
                    <button onclick="return add_question('<?= $slug; ?>')" class="btn btn-secondary">
                        <i class="fa fa-plus"></i> Add Question
                    </button>
                </div>
                <?php } ?>
            </div>
        </div>
    </div>
</div>
<?php include_once 'foottags.php'; ?>