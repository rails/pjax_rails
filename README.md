PJAX for Rails 3.1+
===================

Integrate Chris Wanstrath's [PJAX](https://github.com/defunkt/jquery-pjax) into Rails 3.1+ via the asset pipeline.

To activate, add this to your app/assets/javascripts/application.js (or whatever bundle you use):

    //=require jquery.pjax

In previous versions of `pjax_rails`, most links would automatically use PJAX.
However, this was found to be too inflexible; instead, the types of links you
want to exhibit PJAX should be explicitly enabled:

```js
// app/assets/javascripts/application.js
$(function() {
  $('a:not([data-remote]):not([data-behavior]):not([data-skip-pjax])').pjax('[data-pjax-container]');
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

Declare a custom pjax layout for a controller with the `uses_pjax_layout :pjax` method, where `:pjax` matches the name of your custom layout. For example, first declare the custom layout in your controller:

```ruby
class MyController < ApplicationController
  uses_pjax_layout :pjax

  # More controller code...
end
```
Then create a new pjax layout at `app/views/layouts/pjax.html.erb`. A minimal example with just a `<title>` tag might look like this:

```erb
<title><%= yield(:title) %></title>
<%= yield %>
```

FIXME: Currently the non-pjax layout is hardcoded to "application". Need to delegate that to the specific layout of the controller.
