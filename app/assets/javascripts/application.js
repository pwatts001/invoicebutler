// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery.ui.datepicker
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require masonry/jquery.masonry
//= require masonry/jquery.imagesloaded.min
//= require filter_form
//= require_tree .


function moveScroller() {
    var move = function() {
        var st = $(window).scrollTop();
        var ot = $("#scroller-anchor").offset().top;
        var s = $("#scroller");
        var s2 = $("#scroller2");
        if(st > ot) {
            document.getElementById("scroller").className = "center fatfaceheadertop";
            s2.css({position: "relative", top: ""});
        } else {
            if(st <= ot) {
                document.getElementById("scroller").className = "center fatfaceheader";
                s2.css({position: "fixed", top: "0px"});
            }
        }
    };
    $(window).scroll(move);
    move();
}


