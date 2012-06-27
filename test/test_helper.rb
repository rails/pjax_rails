require 'test/unit'
require 'rails/engine'
require 'action_controller'
require 'action_view/testing/resolvers'

ENV["RAILS_ENV"] = "test"

$:.unshift File.expand_path('../../lib', __FILE__)
require 'pjax'
require 'pjax_rails'

Pjax::Routes = ActionDispatch::Routing::RouteSet.new
Pjax::Routes.draw do
  match '/:controller(/:action(/:id))'
end

class ActiveSupport::TestCase
  setup do
    @routes = Pjax::Routes
  end
end

class ApplicationController < ActionController::Base
  layout nil

  include Pjax::Routes.url_helpers

  self.view_paths = [ActionView::FixtureResolver.new(
    "layouts/application.erb" => "",
    "layouts/default.erb" => "",
    "layouts/pjax.erb" => ""
  )]

  def index
    render :template => ActionView::Template::Text.new("Hello")
  end
end

ApplicationController.send :include, Pjax
