require 'test_helper'

class Hash
  # override Hash#to_query to prevent sorting of params
  def to_query(namespace = nil)
    collect do |key, value|
      unless (value.is_a?(Hash) || value.is_a?(Array)) && value.empty?
        value.to_query(namespace ? "#{namespace}[#{key}]" : key)
      end
    end.compact * "&"
  end
end

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

    get :index, '_pjax' => true

    assert_equal({ 'controller' => 'default_layout', 'action' => 'index' }, Hash[@controller.params])
    assert_nil request.env['rack.request.query_string']
    assert_nil request.env['rack.request.query_hash']
    assert_nil request.env['action_dispatch.request.query_parameters']
    assert_equal '/default_layout', request.original_fullpath
    assert_equal '/default_layout', request.fullpath
  end

  test 'strips pjax params with multiple params at the beginning' do
    request.env['HTTP_X_PJAX'] = true

    get :index, '_pjax' => true, 'first' => '1', 'second' => '2'

    assert_equal({ 'controller' => 'default_layout', 'action' => 'index', 'first' => '1', 'second' => '2' }, Hash[@controller.params])
    assert_nil request.env['rack.request.query_string']
    assert_nil request.env['rack.request.query_hash']
    assert_nil request.env['action_dispatch.request.query_parameters']
    assert_equal '/default_layout?first=1&second=2', request.original_fullpath
    assert_equal '/default_layout?first=1&second=2', request.fullpath
  end

  test 'strips pjax params with multiple params at the middle' do
    request.env['HTTP_X_PJAX'] = true

    get :index, 'first' => '1', '_pjax' => true, 'second' => '2'

    assert_equal({ 'controller' => 'default_layout', 'action' => 'index', 'first' => '1', 'second' => '2' }, Hash[@controller.params])
    assert_nil request.env['rack.request.query_string']
    assert_nil request.env['rack.request.query_hash']
    assert_nil request.env['action_dispatch.request.query_parameters']
    assert_equal '/default_layout?first=1&second=2', request.original_fullpath
    assert_equal '/default_layout?first=1&second=2', request.fullpath
  end

  test 'strips pjax params with multiple params at the end' do
    request.env['HTTP_X_PJAX'] = true

    get :index, 'first' => '1', 'second' => '2', '_pjax' => true

    assert_equal({ 'controller' => 'default_layout', 'action' => 'index', 'first' => '1', 'second' => '2' }, Hash[@controller.params])
    assert_nil request.env['rack.request.query_string']
    assert_nil request.env['rack.request.query_hash']
    assert_nil request.env['action_dispatch.request.query_parameters']
    assert_equal '/default_layout?first=1&second=2', request.original_fullpath
    assert_equal '/default_layout?first=1&second=2', request.fullpath
  end

  test 'sets pjax url' do
    request.env['HTTP_X_PJAX'] = true

    get :index

    assert_equal 'http://test.host/default_layout', response.headers['X-PJAX-URL']
  end

  def get(action, params = {})
    if Rails::VERSION::STRING >= '5.0.0'
      super(action, { params: params })
    else
      super(action, params)
    end
  end
end
