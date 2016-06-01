$(document).ready(function() {

    var transform = function(xml, xslt, success) {
        $.ajax({
            url: 'TransformAction.aspx',
            beforeSend: function() {
                $('#transformedXml').addClass('hidden');
            },
            success: function() {
                $('#transformedXml').removeClass('hidden');
                success.apply(this, arguments);
            },
            data: { xml: xml, xslt: xslt },
            type: "POST",
            dataType: "json"
        });
    }

//    $('#transformedXml').ajaxStart(function() {
//        $(this).addClass('hidden');
//    }).ajaxSuccess(function() {
//        $(this).removeClass('hidden');
//    }).addClass('hidden');


    $('#executeButton').ajaxStart(function() {
        $(this).attr('disabled', true);
    }).ajaxComplete(function() {
        $(this).attr('disabled', false);
    })

    $('#executeButton').click(function() {

        $('#inputTabs').trigger('tabsselect');
        var xml = $('#splitXmlInputWrapper textarea').data('codemirror').getValue();
        var xslt = $('#splitXsltInputWrapper textarea').data('codemirror').getValue();
        transform(xml, xslt, function(transformer) {
            $('#transformedXml textarea').data('codemirror').setValue(transformer.result);
        });
    });






    $('#inputTabs').bind('tabsselect', function() {
        var fromIndex = $(this).tabs('option', 'selected');
        switch (fromIndex) {

            case 0: //split tab
                var xml = $('#splitXmlInputWrapper textarea').data('codemirror').getValue();
                $('#xmlTab textarea').data('codemirror').setValue(xml);

                var xslt = $('#splitXsltInputWrapper textarea').data('codemirror').getValue();
                $('#xsltTab textarea').data('codemirror').setValue(xslt);
                break;
            case 1: //xml tab
                var xml = $('#xmlTab textarea').data('codemirror').getValue();
                $('#splitXmlInputWrapper textarea').data('codemirror').setValue(xml);

                break;
            case 2: //xslt tab
                var xslt = $('#xsltTab textarea').data('codemirror').getValue();
                $('#splitXsltInputWrapper textarea').data('codemirror').setValue(xslt);
            default:
                break;
        }
    });
});