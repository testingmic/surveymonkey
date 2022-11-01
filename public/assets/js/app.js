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

var reset_button = (text = "default") => {
    let button_text = text == "default" ? $(`button[id="poll-button"]`).attr("data-default") : text;
    $(`button[id="poll-button"]`).attr({'disabled': false}).html(button_text);
}

var click_handler = () => {
    $(`div[class="single-choice"] label[class~="choice"]`).on("click", function() {
        let item = $(this);
        $(`div[class="single-choice"] label[class~="choice"]`).removeClass("choice-selected");
        item.addClass("choice-selected");
    });
}

var selectnotice = (msg) => {
    $(`div[class='select-notice']`).html(`<div class="text-danger"><i class="fa fa-info-circle"></i> ${msg}</div>`);
}

$(`button[id="poll-button"]`).on("click", () => {

    $(`div[class='select-notice']`).html(``);

    let data = {};
    
    if($(`input[name='is_required']`).length) {
        let selected_option = $(`input[name='question[choice_id]']:checked`);
        if( !selected_option.length && $(`input[name='is_required']`).val() == 1) {
            selectnotice('This question requires an answer.');
            return false;
        }

        if( selected_option.length !== 1) {
            selectnotice('Only one answer is to be selected.');
            return false
        }

        data = {
            choice_id: selected_option.val(),
            question_id: $(`input[name='question[questionId]']`).val()
        }
    }

    $(`button[id="poll-button"]`)
        .attr({'disabled': true})
        .html(`<i class="fa fa-spin fa-spinner"></i>`);

    $(`div[class='select-notice']`).html(``);

    $.post(`${baseURL}surveys/show_question`, data).then((response) => {
        if( response.code !== 200) {
            Notify(response.data.result, responseCode(response.code));
            reset_button();
        } else {
            $(`div[class="survey-content"] div[class="survey-body"]`).html(response.data.result);
            reset_button("Continue");
            click_handler();
        }
    }).fail((err) => {
        Notify('Sorry! An unexpected error was encountered.');
        setTimeout(() => { reset_button(); }, 1000);
    });
});