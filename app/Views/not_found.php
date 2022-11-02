<?php
$pagetitle = "Survey Not Found (404)";

include_once 'headtags.php';
?>
<div class='dialog-container'>
    <div class='card card-width'>
        <div class='card-content'>
            <img width="560" height="199" src="<?= $baseURL ?>assets/images/notfound.png" />
            <h3><?= $pagetitle ?></h3>
            <p>This survey has been deleted or you are not authorized to access this page.</p>
            If you are the survey owner, make sure that you are logged in to 
            with the same profile that you used to create the survey.
        </div>
        <div class='card-footer'>
            <a class="card-footer-item" href="<?= $baseURL ?>">Back to the Survey App</a>
        </div>
    </div>
</div>
<?php include_once 'foottags.php'; ?>