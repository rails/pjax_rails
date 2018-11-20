require 'test_helper'

class DefaultLayoutControllerTest < ActionController::TestCase
  test 'renders without layout' do
    request.env['HTTP_X_PJAX'] = true

    get :index

    if Rails::VERSION::STRING >= '4.0.0'
      assert_match 'default_layout#index', response.body
    else
      # The behavior for ~> 3.0 varies from 4.0. If there is a layout for parent
      # controller and `layout` in parent controller is set to false it will be
      # rendered anyway with a warning in a log file. It should be set explicit
      # in child controller.
      assert_match 'layouts/application default_layout#index', response.body
    end
  end

  test 'renders with default layout' do
    get :index

    assert_match 'layouts/application default_layout#index', response.body
  end

  test 'prevents pjax' do
    request.env['HTTP_X_PJAX'] = true

    get :prevent_pjax

    assert_equal 406, response.status
  end

  test 'strips pjax params' do
    request.env['HTTP_X_PJAX'] = true

    if Rails::VERSION::STRING >= '5.0.0'
      get :index, params: { '_pjax' => true }
    else
      get :index, '_pjax' => true
    end

    assert_equal({ 'controller' => 'default_layout', 'action' => 'index' }, Hash[@controller.params])
    assert_equal '', request.env['QUERY_STRING']
    assert_nil request.env['rack.request.query_string']
    assert_nil request.env['rack.request.query_hash']
    assert_nil request.env['action_dispatch.request.query_parameters']
    assert_equal '/default_layout', request.original_fullpath
    assert_equal '/default_layout', request.fullpath
  end

  test 'sets pjax url' do
    request.env['HTTP_X_PJAX'] = true

    get :index

    assert_equal 'http://test.host/default_layout', response.headers['X-PJAX-URL']
  end
end
