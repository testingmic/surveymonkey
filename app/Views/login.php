<?php
include_once 'headtags.php';
?>
<div class='dialog-container'>
    <div class='card card-width'>
        <div class='card-content text-center position-relative'>
            <?= form_overlay() ?>
            <h4 class="appname"><?= $AppName ?></h4>
            <img width="150" height="199" src="<?= $baseURL ?>assets/images/notfound.png" />
            <h3 class="border-bottom pb-2 border-primary">App Login</h3>
            <form class="appForm" action="<?= $baseURL ?>api/auth/login">
                <div class="form-group mb-2">
                    <label for="username">Username</label>
                    <input type="text" name="username" id="username" class="form-control text-center">
                </div>
                <div class="form-group mb-3">
                    <label for="password">Password</label>
                    <input type="password" name="password" id="password" class="form-control text-center">
                </div>
                <div class="form-group">
                    <button class="btn btn-success"><i class="fa fa-lock"></i> Login</button>
                </div>
            </form>
        </div>
        <div class='card-footer'>
            <a class="card-footer-item" href="<?= $baseURL ?>forgotten">Forgotten Password</a>
        </div>
    </div>
</div>
<?php include_once 'foottags.php'; ?>