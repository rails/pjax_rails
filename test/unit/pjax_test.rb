require 'test_helper'

class WithPjax < ApplicationController; end

class WithoutPjax < ApplicationController; end

class OverrideLayout < ApplicationController
  protected
  def pjax_layout; 'pjax' end
  def default_layout; 'default' end
end

class WithPjaxTest < ActionController::TestCase
  setup do
    request.env['HTTP_X_PJAX'] = true
    request.env['X-PJAX-Container'] = 'container'
    get :index
  end

  test 'pjax_request? is true' do
    assert_equal @controller.send(:pjax_request?), true
  end

  test 'renders with no layout' do
    assert_template nil
  end

  test 'pjax_container returns the X-PJAX-Container' do
    assert_equal @controller.send(:pjax_container), 'container'
  end
end

class WithoutPjaxTest < ActionController::TestCase
  test 'pjax_request? is false' do
    assert_equal @controller.send(:pjax_request?), false
  end

  test 'renders application layout' do
    get :index
    assert_template 'application'
  end
end

class OverrideLayoutTest < ActionController::TestCase
  test 'renders the layout from default_layout' do
    get :index
    assert_template 'default'
  end

  test 'renders the layout from pjax_layout' do
    request.env['HTTP_X_PJAX'] = true
    get :index
    assert_template 'pjax'
  end
end
