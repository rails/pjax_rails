PJAX for Rails 3.1+
===================

Integrate Chris Wanstrath's PJAX into Rails 3.1+ via the asset pipeline.

To activate, add this to your app/assets/javascripts/application.js (or whatever bundle you use):

  // =require pjax

All links that matches $('a:not([data-remote]):not([data-behavior])') will then use PJAX. 

FIXME: Currently the layout is hardcoded to "application". Need to delegate that to the specific layout of the controller.