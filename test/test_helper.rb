ENV['RAILS_ENV'] ||= 'test'

require 'test/unit'
require 'dummy/config/environment'
require 'rails/test_help'
require 'capybara/poltergeist'

Capybara.app = Rails.application
Capybara.default_driver = :poltergeist
class ActiveSupport::IntegrationCase < ActiveSupport::TestCase
  include Capybara::DSL

  def teardown
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end
end
