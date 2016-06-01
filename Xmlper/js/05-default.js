


$(document).ready(function() {


    $('a[href^=#]').click(function(e) {
        e.preventDefault();
    });

   
    $('textarea.xml-display').each(function() {
        var textarea = this;
        var editor = CodeMirror.fromTextArea(this, {
            lineNumbers:true,
            readOnly: $(textarea).attr('readonly')
        });
        editor.setValue($(textarea).val());
        $(this).data('codemirror', editor);

    });
    

    $('#inputTabs').tabs();

    $('button').button();




    $.ajaxSetup({
        timeout: 15000
    });

    $('.ajax-loading').ajaxStart(function() {
        $(this).removeClass('hidden');
    }).ajaxStop(function() {
        $(this).addClass('hidden');
    }).addClass('hidden');



    $('.ajax-error').ajaxStart(function() {
        $(this).addClass('hidden');
    }).ajaxError(function(event, xmlHttpRequest) {
        if (xmlHttpRequest.readyState != 4) {
            $('label', this).text('Unable to perform action, timeout may have been exceeded');
        }
        else if (!xmlHttpRequest.responseText || xmlHttpRequest.responseText == '') {
            $('label', this).text('An error has occured');
        }
        else {
            try {
                var obj = eval('(' + xmlHttpRequest.responseText + ')');
                $('label', this).text(obj.errorMessage);
            }
            catch (ex) {
                $('label', this).text(xmlHttpRequest.responseText);
            }
        }
        $(this).removeClass('hidden');
    }).addClass('hidden');




    $('.header-button').hover(
        function() { $(this).addClass('ui-state-hover'); },
        function() { $(this).removeClass('ui-state-hover'); }
    );

    $('.prettify-button').click(function() {
        var codemirror = $(this).parents('.header-bar').siblings('textarea').data('codemirror')
        var xml = codemirror.getValue();

        $.ajax({
            url: 'PrettifyAction.aspx',
            data: { xml: xml },
            type: "POST",
            dataType: "json",
             success: function(response){
                codemirror.setValue(response.result);
             },
        });

    });

});