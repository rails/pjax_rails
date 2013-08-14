require 'test_helper'

class PjaxControllerTest < ActionController::TestCase
  test 'renders without layout' do
    request.env['HTTP_X_PJAX'] = true

    get :index

    assert_equal 'pjax#index', response.body
  end

  test 'renders with default layout' do
    get :index

    assert_equal 'layouts/application pjax#index', response.body
  end

  test 'prevents pjax' do
    request.env['HTTP_X_PJAX'] = true

    get :prevent_pjax

    assert_equal 406, response.status
  end

  test 'strips pjax params' do
    request.env['HTTP_X_PJAX'] = true

    get :index, '_pjax' => true

    assert_equal({ 'controller' => 'pjax', 'action' => 'index' }, @controller.params)
    assert_equal '', request.env['QUERY_STRING']
    assert_nil request.env['rack.request.query_string']
    assert_nil request.env['rack.request.query_hash']
    assert_nil request.env['action_dispatch.request.query_parameters']
    assert_equal '/pjax', request.original_fullpath
    assert_equal '/pjax', request.fullpath
  end

  test 'sets pjax url' do
    request.env['HTTP_X_PJAX'] = true

    get :index

    assert_equal 'http://test.host/pjax', response.headers['X-PJAX-URL']
  end
end
