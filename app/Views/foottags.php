    <script>var baseURL = "<?= $baseURL ?>";</script>
    <script src="<?= $baseURL ?>assets/js/jquery.js"></script>
    <script src="<?= $baseURL ?>assets/js/sweetalert.js"></script>
    <script src="<?= $baseURL ?>assets/js/toastr.js"></script>
    <script src="<?= $baseURL ?>assets/js/fingerpint.js"></script>
    <script src="<?= $baseURL ?>assets/js/app.js"></script>
    <?php if(isset($manageSurvey)) { ?>
        <script src="<?= $baseURL ?>assets/js/trix.js"></script>
        <script src="<?= $baseURL ?>assets/js/dashboard.js"></script>
    <?php } ?>
</body>
</html>