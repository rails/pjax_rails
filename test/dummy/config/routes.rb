Dummy::Application.routes.draw do
  get '/:controller(/:action(/:id))'
  get '/favicon.ico' => 'capybara#favicon'
end
