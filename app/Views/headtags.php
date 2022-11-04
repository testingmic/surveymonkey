<?php
// globalize the variables
global $AppName, $baseURL, $sessObj, $isLoggedIn;

// create config object
$configObj = config('App');
$sessObj = session();

// set the some important variables
$AppName = $configObj->AppName;
$rootURL = $configObj->baseURL;
$baseURL = trim($rootURL, '/') . "/";

// get the route information
$URI = uri_string();
$SPLIT = explode("/", $URI);
$Route = $SPLIT[0];

// user is logged in
$isLoggedIn = !empty($sessObj->_userApiToken) && !empty($sessObj->_clientId) && !empty($sessObj->_userId);
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="icon" type="image/jpeg" href="<?= $baseURL ?>assets/images/favicon.jpg">
    <title><?= $pagetitle ?? "Home" ?> - <?= $AppName ?? null ?></title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content='width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no' name='viewport'>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Oswald:wght@500&amp;display=swap" media="all" />
    <link rel="stylesheet" href="<?= $baseURL ?>assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="<?= $baseURL ?>assets/css/fontawesome.css">
    <link rel="stylesheet" href="<?= $baseURL ?>assets/css/toastr.css">
    <link rel="stylesheet" href="<?= $baseURL ?>assets/css/trix.css">
    <link rel="stylesheet" href="<?= $baseURL ?>assets/css/custom.css">
</head>
<body>
    <div class="survey-container">
        <div class="survey-header">
            <?php if (isset($survey, $isResult)) { ?>
                <div class="<?= $isResult ? "container" : "header-title"; ?>">
                    <?= $survey['title'] ?> <?= $isResult ? " - Results" : null ?>
                </div>
            <?php } else { ?>
                <div class="container">
                    <div class="d-flex justify-content-between">
                        <div>
                            <a href="<?= $baseURL ?>" class="text-white">
                                <i class="fa fa-bezier-curve"></i>
                            </a> <?= $AppName ?>
                        </div>
                        <?php if( $isLoggedIn ) { ?>
                            <div class="userprofile">
                                <ul class="nav nav-tabs">
                                    <li class="nav-item dropdown ms-auto">
                                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                                            <?= !empty(get_meta($metadata, 'fullname')) ? get_meta($metadata, 'fullname') : $sessObj->_userName ?>
                                        </a>
                                        <div class="dropdown-menu dropdown-menu-end">
                                            <a href="<?= $baseURL ?>account/settings" class="dropdown-item">
                                                <i class="fa fa-cog"></i> Account Settings
                                            </a>
                                            <a href="<?= $baseURL ?>account/support" class="dropdown-item">
                                            <i class="fa fa-life-ring"></i> Support
                                            </a>
                                            <div class="dropdown-divider"></div>
                                            <a href="#" onclick="return logout()" class="dropdown-item">
                                                <i class="fa fa-lock"></i> Logout
                                            </a>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        <?php } ?>

                    </div>
                </div>
            <?php } ?>
        </div>