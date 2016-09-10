$(function () {
  $('[data-toggle="popover"]').popover()
})

$(":file").filestyle({icon: false});

$('form[name=convert]').submit(function(){

    // Maybe show a loading indicator...

    $.get($(this).attr('action'), $(this).serialize(), function(res){
        // Do something with the response `res`
        console.log(res);
        location.reload();
        // Don't forget to hide the loading indicator!
    });

    return false; // prevent default action

});