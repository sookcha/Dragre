// Application's Default Javascript File
// Written by Son Ho Sung

//= require jquery
//= require jquery_ujs
//= require app
//= require_tree .

$(document).ready(function() {
  $('tr').hover(function() {
    $(this).addClass('hover');
  },
  function() {
    $(this).removeClass('hover');

  });
});