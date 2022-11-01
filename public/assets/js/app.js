var Notify = (message, theme = "danger", icon = 'fa-bell-o') => {
    toastr.options.positionClass = 'toast-top-right';
    toastr.options.extendedTimeOut = 0;
    toastr.options.timeOut = 4000;
    toastr.options.closeButton = true;
    toastr.options.iconClass = icon + ' toast-' + theme;
    toastr['custom'](message);
}

var responseCode = (code) => {
    return code == 200 ? "success" : "danger";
}

$(`button[class~="begin-button"]`).on("click", () => {
    $(`button[class~="begin-button"]`)
        .attr({'disabled': true})
        .html(`<i class="fa fa-spin fa-spinner"></i>`);

    $.post(`${baseURL}surveys/begin`).then((response) => {
        
        Notify(response.data.result, responseCode(response.code));

    }).fail((err) => {
        Notify('Sorry! An unexpected error was encountered.');
        setTimeout(() => {
            $(`button[class~="begin-button"]`)
                .attr({'disabled': false})
                .html($(`button[class~="begin-button"]`).attr("data-default"));
        }, 1000);
    });


});