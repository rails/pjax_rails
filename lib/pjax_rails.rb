require 'pjax'

module PjaxRails
  class Engine < ::Rails::Engine
    initializer "pjax_rails.add_controller" do
      config.to_prepare { ApplicationController.send :include, Pjax }
    end
  end
end