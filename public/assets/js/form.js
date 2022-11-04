var release_form = () => {
    formoverlay.hide();
    $(`form[class="appForm"] button[type="submit"]`).attr({'disabled': false});
    $(`button[type="submit"]`).html(`<i class="fa fa-save"></i> Save`);
}

$(`form[class="appForm"]`).on("submit", function(evt) {
    evt.preventDefault();
    
    let form = $(`form[class="appForm"]`).serializeArray();
    let action = $(`form[class="appForm"]`).attr("action");

    $(`form[class="appForm"] button[type="submit"]`).attr({'disabled': true});
    $(`button[type="submit"]`).html(`<i class="fa fa-spin fa-spinner"></i>`);

    $.each($(`trix-editor`), function() {
        let trix_name = $(this).attr("name");
        let trix_content = $(this).html().replace(/<!--block-->/ig, '');
        let trix = {
            'name': trix_name,
            'value': _html_entities(trix_content)
        };
        form.push(trix);
    });

    formoverlay.show();
    $.post(`${action}`, form).then((response) => {
        Notify(response.data.result, responseCode(response.code));
        if(response.code == 200) {
            if(response.data.additional !== undefined) {
                if(response.data.additional.clear !== undefined) {
                    $(`form[class="appForm"] *`).val(``);
                    $(`trix-editor`).html(``);
                }
                if(response.data.additional.href !== undefined) {
                    window.location.href = `${baseURL}${response.data.additional.href}`;
                }
            }
        }
        
        if(typeof release_form == 'function') {
            release_form();
        }

    }).fail((err) => {
        if(typeof release_form == 'function') {
            release_form();
        }
        Notify("Sorry! An unexpected error occurred while processing the request.");
    });
});