<?php
include_once 'headtags.php';
?>
<div class='dialog-container'>
    <div class='card card-width'>
        <div class='card-content text-center'>
            <h4 class="appname"><?= $AppName ?></h4>
            <img width="150" height="199" src="<?= $baseURL ?>assets/images/notfound.png" />
            <h3 class="border-bottom pb-2 border-primary">
                <?= $pagetitle ?? "Not Found (404)" ?>
            </h3>
            <p>
                <?= $content ?? 'This survey has been deleted or you are not authorized to access this page.</p>
                If you are the survey owner, make sure that you are logged in to 
                with the same profile that you used to create the survey.' ?>
            </p>

        </div>
        <div class='card-footer'>
            <a class="card-footer-item" href="<?= $baseURL ?>">Back to the Survey App</a>
        </div>
    </div>
</div>
<?php include_once 'foottags.php'; ?>