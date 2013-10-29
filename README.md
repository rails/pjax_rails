PJAX for Rails 3.2+
===================
[![Build Status](https://travis-ci.org/rails/pjax_rails.png?branch=master)](https://travis-ci.org/rails/pjax_rails)

Integrate Chris Wanstrath's [PJAX](https://github.com/defunkt/jquery-pjax) into Rails 3.1+ via the asset pipeline.

To activate, add this to your app/assets/javascripts/application.js (or whatever bundle you use):

```js
//=require jquery.pjax
```

Then choose all the types of links you want to exhibit PJAX:

```js
// app/assets/javascripts/application.js
$(function() {
  $(document).pjax('a:not([data-remote]):not([data-behavior]):not([data-skip-pjax])', '[data-pjax-container]')
});
```

For this example, the PJAX container has to be marked with data-pjax-container
attribute, so for example:

```erb
<body>
  <div>
    <!-- This will not be touched on PJAX updates -->
    <%= Time.now %>
  </div>

  <div data-pjax-container>
    <!-- PJAX updates will go here -->
    <%= content_tag :h3, 'My site' %>
    <%= link_to 'About me', about_me_path %>
    <!-- The following link will not be pjax'd -->
    <%= link_to 'Google', 'http://google.com', 'data-skip-pjax' => true %>
  </div>
</body>
```
