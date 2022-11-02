$(`span[class~="trix-button-group--file-tools"], 
    span[class~="trix-button-group-spacer"],
    span[class~="trix-button-group--history-tools"]`).remove();


var _html_entities = (str) => {
    return String(str).replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
}

var release_form = () => {
    $(`form[class="appForm"] *`).attr({'disabled': false});
    $(`button[type="submit"]`).html(`<i class="fa fa-save"></i> Save`);
}

$(`form[class="appForm"]`).on("submit", function(evt) {
    evt.preventDefault();
    
    let form = $(`form[class="appForm"]`).serializeArray();

    $(`form[class="appForm"] *`).attr({'disabled': true});
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

    $.post(`${baseURL}surveys/save`, form).then((response) => {
        Notify(response.data.result, responseCode(response.code));
        if(response.code == 200) {
        }
        release_form();
    }).fail((err) => {
        release_form();
        Notify("Sorry! An unexpected error occurred while processing the request.");
    });
});