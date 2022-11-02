<?php
include_once 'headtags.php';
?>
<div class="survey-container pb-5">
    <div class="survey-header">
        <div class="header-title">
            <?= $survey['title'] ?>
        </div>
    </div>
    <div class="survey-content">
        <div class="survey-body">
            <?php if (!empty($survey['cover_art'])) { ?>
                <div class="fluid-image">
                    <img src="<?= $baseURL . $survey['cover_art'] ?>" alt="">
                </div>
            <?php } ?>
            <div><?= $survey['description'] ?></div>
        </div>
        <div class="text-center mt-3">
            <button id="poll-button" data-default="<?= $survey['button_text'] ?>" class="btn btn-success begin-button">
                <?= $isContinue ? "Continue" : $survey['button_text'] ?>
            </button>
            <div class="percentage"></div>
            <input type="hidden" name="proceed_to_load" value="continue">
        </div>
    </div>
</div>
<?php include_once 'foottags.php'; ?>