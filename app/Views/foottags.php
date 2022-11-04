    
    </div>
    <section hidden class="output"><div class="heading">Getting the visitor identifier...</div></section>
    <script>var baseURL = "<?= $baseURL ?>";</script>
    <script src="<?= $baseURL ?>assets/js/jquery.js"></script>
    <script src="<?= $baseURL ?>assets/js/sweetalert.js"></script>
    <script src="<?= $baseURL ?>assets/js/toastr.js"></script>
    <!-- <script src="<?= $baseURL ?>assets/js/fingerprint.js"></script> -->
    <script src="<?= $baseURL ?>assets/js/app.js?v=1.0.41"></script>
    <?php if(isset($surveySlug, $votersGUID, $ip_address)) { ?>
        <script>
            <?php if( empty($sessObj->userFingerprint) ) { ?>
            const fpPromise = import('https://fpcdn.io/v3/hXGuNdSTmPCM5hWHXWUj').then(FingerprintJS => FingerprintJS.load())
            fpPromise.then(fp => fp.get()).then(result => {
                const visitorId = result.visitorId
                userFingerprint = visitorId;
            });
            <?php } else { ?>
                userFingerprint = "<?= $sessObj->userFingerprint ?>";
            <?php } ?>
        </script>
    <?php } ?>
    <script src="<?= $baseURL ?>assets/js/bootstrap.js"></script>
    <?php if(isset($manageSurvey)) { ?>
        <script src="<?= $baseURL ?>assets/js/trix.js"></script>
        <script src="<?= $baseURL ?>assets/js/dashboard.js?v=1.0"></script>
    <?php } ?>
    <script src="<?= $baseURL ?>assets/js/form.js"></script>
</body>
</html>