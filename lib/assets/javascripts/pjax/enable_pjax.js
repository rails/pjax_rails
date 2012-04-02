// DEPRECATED: This default activation selector is too domain specific
// and can not be easily customized.
//
// This file will be removed in 0.5.

$('a:not([data-remote]):not([data-behavior]):not([data-skip-pjax])')
  .pjax('[data-pjax-container]');
