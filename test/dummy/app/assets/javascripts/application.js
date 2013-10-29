//= require jquery
//= require jquery_ujs
//= require jquery.pjax
//= require_tree .

$(function() {
    $(document).pjax('a:not([data-skip-pjax])', '[data-pjax-container]');
});
