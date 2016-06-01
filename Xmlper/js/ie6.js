$(document).ready(function() {

    //hiding and showing codemirror causes ie6 to display it oddly
    //this just removes and adds the code mirror wrap, this makes
    //ie recalculate its displaly and show it correctly
    $('#inputTabs').bind('tabsshow', function() {
        $('.CodeMirror-wrapping').each(function() {
            $(this).appendTo($(this).parent());
        });
    });


    //Fixes issue with google ad-sense where it does not vertically align
//itself correctly
    $('.banner-ad iframe').css('display', 'block');


});
