$(document).ready(function() {


    var xpathSelect = function(data, success) {
        $.ajax({
            url: 'XPathAction.aspx',
            success: success,
            data: data,
            type: 'POST',
            dataType: 'json'
        });
    }



    $('#emptyResultMessage, #resultContainer').ajaxStart(function() {
        $(this).addClass('hidden');
    });

    $('#executeButton').click(function() {
        $('#xmlTab textarea').val($('#xmlTab textarea').data('codemirror').getCode());
        var data = $('input[name=prefix], input[name=namespace], #xpathInput, #xmlTab textarea').serialize();

        /*var xml = $('#xmlTab textarea').data('codemirror').getCode();
        var xpath = $('#xpathInput').val();

        var prefixes = $('input[name=prefix]').map(function() { return $(this).val(); });
        var namepaces = $('input[name=namespace]').map(function() { return $(this).val(); });*/

        xpathSelect(data, function(results) {
            var $ul = $('#resultContainer ul');
            $ul.children().remove();
            if (!results || results.length == 0) {
                $('#emptyResultMessage').removeClass('hidden');
            }
            else {
                $('#resultContainer').removeClass('hidden');
            }

            $.each(results, function(i, element) {
                var $li = $('<li/>')
                highlightText(element, $li[0]);
                $li.appendTo($ul);
            });
        });
    });


    $('.add-namespace-link').click(function(e) {
        e.preventDefault();
        $('#namespaceTable .template').clone().removeClass('template').appendTo('#namespaceTable');
    });

    $('.remove-namespace-link', '#namespaceTable').live('click', function(e) {
        e.preventDefault();
        $(this).parents('tr').remove();
    });

});