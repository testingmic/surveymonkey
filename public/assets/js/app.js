var surveyResults, userFingerprint,
    formoverlay = $(`div[class="formoverlay"]`),
    selectedQuestion;
    
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
    $(`button[id="poll-button"]`).addClass('shaking');
    $(`div[class='select-notice']`).html(`<div class="text-danger shaking"><i class="fa fa-info-circle"></i> ${msg}</div>`);
    setTimeout(() => {
        $("html, body").animate({ scrollTop: 0 }, "slow");
    }, 500);
}

var refresh_handler = () => {
    $.post(`${baseURL}surveys/show_question`, {refresh_poll: true}).then((response) => {
        
    });
}

var guid = function() {
    var nav = window.navigator;
    var screen = window.screen;
    var guid = "";
    guid += nav.userAgent.replace(/\D+/g, '');
    guid += screen.height || '';
    guid += screen.width || '';
    guid += screen.pixelDepth || '';

    return guid;
};

$(`button[id="poll-button"]`).on("click", async function() {

    $(`div[class='select-notice']`).html(``);
    $(`div[id="skipquestion"]`).addClass('hidden');
    $(`button[id="poll-button"]`).removeClass('shaking');

    let data = {};

    if($(`input[name="proceed_to_load"]`).val() == 'poll-refresh') {
        refresh_handler();
    }

    if($(`input[name='is_required']`).length) {
        
        let selected_option = $(`input[name='question[choice_id]']:checked`);
        let is_required = $(`input[name='is_required']`).val();

        if(is_required == 0) {
            $(`div[id="skipquestion"]`).removeClass('hidden');
        }

        if( !selected_option.length && is_required == 1) {
            selectnotice('This question requires an answer.');
            return false;
        }

        let hasSkipped = $(`input[name="hasSkipped"]`).val();

        if(hasSkipped == "No" && (selected_option.length !== 1)) {
            selectnotice('Select at least one answer to proceed.');
            return false
        }

        let user_uid = userFingerprint !== undefined ? userFingerprint : guid();

        data = {
            guid: user_uid,
            choice_id: selected_option.length ? selected_option.val() : "",
            question_id: $(`input[name='question[questionId]']`).val()
        }
    }
    
    multi_voting_check();
    
    $(`button[id="poll-button"]`).attr({'disabled': true}).html(`<i class="fa fa-spin fa-spinner"></i>`);

    $(`div[class='select-notice']`).html(``);

    $.post(`${baseURL}surveys/show_question`, data).then((response) => {
        if( response.code !== 200) {
            Notify(response.data.result, responseCode(response.code));
            reset_button();
        } else {
            $(`div[class="survey-content"] div[class="survey-body"]`).html(response.data.result);

            if(response.data.additional !== undefined) {
                if(response.data.additional.percentage !== undefined) {
                    $(`div[class~="percentage"]`).html(response.data.additional.percentage);
                }
                reset_button(response.data.additional.button_text);

                if(response.data.additional.button_id !== undefined) {
                    $(`input[name="proceed_to_load"]`).val(response.data.additional.button_id);
                } else {
                    $(`input[name="proceed_to_load"]`).val('continue');
                }

                if(response.data.additional.guids !== undefined) {
                    votersGUID = response.data.additional.guids;
                } 

                if(response.data.additional.can_skip !== undefined) {
                    if(response.data.additional.can_skip == 'Yes') {
                        $(`div[id="skipquestion"]`).removeClass('hidden');
                    } else {
                        $(`div[id="skipquestion"]`).addClass('hidden');
                    }
                } else {
                    $(`div[id="skipquestion"]`).addClass('hidden');
                }

            }

            click_handler();
        }
        $(`input[name="hasSkipped"]`).val("No");
    }).fail((err) => {
        Notify('Sorry! An unexpected error was encountered.');
        setTimeout(() => { reset_button(); }, 1000);
    });
    
});

var skipped_question = function() {
    $(`input[name="hasSkipped"]`).val("Yes");
    $(`button[id="poll-button"]`).trigger("click");
}

var logout = () => {
    $.post(`${baseURL}auth/logout`).then(() => {
        Notify("You are successfully logged out", "success");
        setTimeout(() => {
            window.location.href = `${baseURL}`;
        }, 1000);
    });
}

var multi_voting_check = function() {
    if($(`input[name="multipleVoting"]`).length) {
        let value = $(`input[name="multipleVoting"]`).val();
        if(value == "No") {
            let user_guid = userFingerprint !== undefined ? userFingerprint : guid();
            if($.inArray(user_guid, votersGUID) !== -1) {
                $(`button[id="poll-button"], div[id="skipquestion"]`).remove();
                $(`div[class~="percentage"]`).html(`<button class="btn btn-success begin-button">One vote allowed!</button>`);
            }
        }
    }
    let button_text = $(`button[id="poll-button"]`).attr("data-default");
    $(`button[id="poll-button"]`).attr({'disabled': false}).html(button_text);
}

setTimeout(() => {
    multi_voting_check();
}, 3000);