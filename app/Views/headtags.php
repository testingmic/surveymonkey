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
$isLoggedIn = !empty($sessObj->_userApiToken) && !empty($sessObj->_schoolId) && !empty($sessObj->_userId);
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
    <link rel="stylesheet" href="<?= $baseURL ?>assets/css/custom.css">
</head>
<body>