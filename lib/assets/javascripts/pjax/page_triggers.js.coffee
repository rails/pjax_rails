$(document).ready ->
  $(document).trigger 'pageChanged'
  $(document).trigger 'pageUpdated'

$(document).bind 'end.pjax', ->
  $(document).trigger 'pageChanged'
  $(document).trigger 'pageUpdated'

$(document).bind 'ajaxComplete', ->
  $(document).trigger 'pageUpdated'
