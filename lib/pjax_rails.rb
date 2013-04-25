require 'pjax'

module PjaxRails
  class Engine < ::Rails::Engine
    initializer "pjax_rails.add_controller" do
      config.to_prepare { Pjax.setup }
    end
  end
end
