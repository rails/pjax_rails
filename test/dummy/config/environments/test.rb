Dummy::Application.configure do
  config.cache_classes = true

  config.eager_load = false

  config.serve_static_assets  = true

  if Rails::VERSION::STRING >= '5.0.0'
    config.public_file_server.headers = { 'Cache-Control' => 'public, max-age=3600' }
    config.action_controller.permit_all_parameters = true
  else
    config.static_cache_control = "public, max-age=3600"
  end

  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  config.action_dispatch.show_exceptions = false

  config.action_controller.allow_forgery_protection = false

  config.active_support.deprecation = :notify
end
