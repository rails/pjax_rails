require 'test/unit'
require 'rails'
require 'action_controller'
require 'pjax_rails'
require 'rails/test_help'

Class.new(Rails::Application) do |app|
  app.configure do
    config.active_support.deprecation = :notify
    config.secret_token = 'a966a729a228e5d3edf00997e7b7eab7'
    config.eager_load = false

    routes {
      get '/:controller(/:action(/:id))'
    }
  end

  app.initialize!
end

require 'action_view/testing/resolvers'

class ApplicationController < ActionController::Base
  include Rails.application.routes.url_helpers
end

class PjaxController < ApplicationController
  append_view_path ActionView::FixtureResolver.new('layouts/application.html.erb' => 'layouts/application <%= yield %>')
  append_view_path ActionView::FixtureResolver.new('pjax/index.html.erb' => 'pjax#index')
  append_view_path ActionView::FixtureResolver.new('pjax/prevent_pjax.html.erb' => 'pjax#prevent_pjax')

  def prevent_pjax
    prevent_pjax!
  end
end

class WithLayoutController < ApplicationController
  layout 'with_layout'

  append_view_path ActionView::FixtureResolver.new('layouts/with_layout.html.erb' => 'layouts/with_layout <%= yield %>')
  append_view_path ActionView::FixtureResolver.new('with_layout/index.html.erb' => 'with_layout#index')
end
