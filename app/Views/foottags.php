    <section hidden class="output"><div class="heading">Getting the visitor identifier...</div></section>
    <script>var baseURL = "<?= $baseURL ?>";</script>
    <script src="<?= $baseURL ?>assets/js/jquery.js"></script>
    <script src="<?= $baseURL ?>assets/js/sweetalert.js"></script>
    <script src="<?= $baseURL ?>assets/js/toastr.js"></script>
    <script src="<?= $baseURL ?>assets/js/fingerprint.js"></script>
    <script src="<?= $baseURL ?>assets/js/app.js?v=1.0.1"></script>
    <?php if(isset($manageSurvey)) { ?>
        <script src="<?= $baseURL ?>assets/js/trix.js"></script>
        <script src="<?= $baseURL ?>assets/js/dashboard.js"></script>
    <?php } ?>
</body>
</html>