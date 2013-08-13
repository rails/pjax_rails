require 'pjax'

module PjaxRails
  class Engine < ::Rails::Engine
    initializer 'pjax_rails.add_controller' do
      ActiveSupport.on_load :action_controller do
        ActionController::Base.send :include, Pjax
      end
    end
  end
end
