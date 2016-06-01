$(document).ready(function(){

    var validate = function(xml, schema, success){
        $.ajax({
          url: 'ValidateAction.aspx',
          success: success,
          data:{xml:xml, schema:schema},
          type:'POST',
          dataType:'json'
        });
    }
    
    var selectNode = function(line, position){
        var $tabs = $('#inputTabs');
        var selectedIndex = $tabs.tabs('option', 'selected');
        var codemirror;
        switch(selectedIndex){
            case 0: //split
                codemirror = $('#splitXmlInputWrapper textarea').data('codemirror');
                break;
            case 1: //xml
                codemirror = $('#xmlTab textarea').data('codemirror');
                break;
            default: //else
                //select the xml tab
                $tabs.tabs('select', 1);
                codemirror = $('#xmlTab textarea').data('codemirror');
                break;
        }
        var lineHandle = codemirror.nthLine(line);
        codemirror.selectLines(lineHandle, position);
        
    }
    
    $('#validationResult, #validationSuccess').ajaxStart(function() {
      $(this).addClass('hidden');
    });
    
    
    $('#executeButton').ajaxStart(function() {
        $(this).attr('disabled', true);
    }).ajaxComplete(function(){
        $(this).attr('disabled', false);
    })

    $('#executeButton').click(function(){

        $('#inputTabs').trigger('tabsselect');
        var xml = $('#splitXmlInputWrapper textarea').data('codemirror').getCode();
        var schema = $('#splitSchemaInputWrapper textarea').data('codemirror').getCode();
        validate(xml, schema, function(issueList) {
            if(!issueList || issueList.length==0){
                $('#validationSuccess').removeClass('hidden');
                return;
            }
            
            
            var $ul = $('#validationResult ul');
            $ul.children().remove();
            $.each(issueList, function(){
                var line = this.lineNumber || 0;
                var position = this.linePosition || 0;
                var message = this.message;
                
                var $messageElement = $('<span/>').text(message).addClass('validation-message');
                var $positonElement = $('<a href="#"/>').text('(line '+line+' position '+position+')').addClass('validation-position');
                $positonElement.click(function(ev){
                    selectNode(line, position);
                    ev.preventDefault();
                });
                $li = $('<li/>').append($messageElement).append($positonElement).appendTo($ul);
                
                if(this.severity == 'Error'){
                    $li.addClass('ui-state-error ui-corner-all message-box');
                    $li.prepend($('<span class="ui-icon ui-icon-alert"/>'));
                }
                else{
                    $li.addClass('ui-state-highlight ui-corner-all message-box');
                    $li.prepend($('<span class="ui-icon ui-icon-info"/>'));
                }
                
            });
            $('#validationResult').removeClass('hidden');
        });
    });

    


    
    
    $('#inputTabs').bind('tabsselect', function(){
        var fromIndex = $(this).tabs('option', 'selected');
        switch(fromIndex){
        
            case 0://split tab
                var xml = $('#splitXmlInputWrapper textarea').data('codemirror').getCode();
                $('#xmlTab textarea').data('codemirror').setCode(xml);
                
                var xslt = $('#splitSchemaInputWrapper textarea').data('codemirror').getCode();
                $('#schemaTab textarea').data('codemirror').setCode(xslt);
                break;
            case 1://xml tab
                var xml = $('#xmlTab textarea').data('codemirror').getCode();
                $('#splitXmlInputWrapper textarea').data('codemirror').setCode(xml);
                
                break;
            case 2://xslt tab
                var xslt = $('#schemaTab textarea').data('codemirror').getCode();
                $('#splitSchemaInputWrapper textarea').data('codemirror').setCode(xslt);
            default:
                break;
        }
    });
});