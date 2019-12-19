ENV['RAILS_ENV'] ||= 'test'

require 'dummy/config/environment'
require 'rails/test_help'
require 'capybara/rails'
require 'capybara/poltergeist'

Capybara.app = Rails.application
Capybara.server = :webrick
Capybara.default_driver = :poltergeist

class ActiveSupport::IntegrationCase < ActiveSupport::TestCase
  include Capybara::DSL

  def teardown
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end
end

# Rails 4.2 call `initialize` inside `recycle!`.
# However Ruby 2.6 doesn't allow calling `initialize` twice.
# More info: https://github.com/rails/rails/issues/34790
if RUBY_VERSION >= "2.6.0" && Rails.version < "5"
  module ActionController
    class TestResponse < ActionDispatch::TestResponse
      def recycle!
        @mon_mutex_owner_object_id = nil
        @mon_mutex = nil
        initialize
      end
    end
  end
end
