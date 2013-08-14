require 'test_helper'

class WithLayoutControllerTest < ActionController::TestCase
  test 'renders with layout for pjax request' do
    request.env['HTTP_X_PJAX'] = true

    get :index

    assert_equal 'layouts/with_layout with_layout#index', response.body
  end

  test 'renders with layout for regular request' do
    get :index

    assert_equal 'layouts/with_layout with_layout#index', response.body
  end
end
