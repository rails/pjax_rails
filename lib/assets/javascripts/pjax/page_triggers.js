// DEPRECATED: Move these events into your application if you want to
// continue using them.
//
// This file will be removed in 0.5.

$(document).ready(function() {
  $(document).trigger('pageChanged');
  $(document).trigger('pageUpdated');
});

$(document).bind('pjax:end', function() {
  $(document).trigger('pageChanged');
  $(document).trigger('pageUpdated');
});

$(document).bind('ajaxComplete', function() {
  $(document).trigger('pageUpdated');
});
