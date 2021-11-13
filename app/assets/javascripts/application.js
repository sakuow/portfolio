// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
// jquery_ujsはいらない？
//= require rails-ujs
//= require turbolinks
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require gmaps/google
//= require_tree .
//= require activestorage

/*global $*/
$(document).on('turbolinks:load', function() {
  $(".form").skippr({
    transition : 'slide',
    speed : 1000,
    arrows : false,
    autoPlay : true,
    childrenElementType : 'div',
    autoPlayDuration : 3000,
    hidePrevious : true
  })
});
