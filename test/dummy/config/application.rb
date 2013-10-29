require File.expand_path('../boot', __FILE__)

require 'rails'
require 'action_controller/railtie'
require 'sprockets/railtie'

require 'jquery-rails'
require 'pjax_rails'

Bundler.require(:default, Rails.env)

module Dummy
  class Application < Rails::Application
    config.secret_token = 'a966a729a228e5d3edf00997e7b7eab7'
    config.assets.enabled = true
  end
end
