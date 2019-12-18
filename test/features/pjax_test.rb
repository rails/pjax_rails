require 'test_helper'

class PjaxTest < ActiveSupport::IntegrationCase
  test 'loads plain text' do
    visit '/capybara'

    click_on 'plainText'

    assert page.has_content?('Will not be touched')
    assert page.has_no_content?('Pjax container')
    assert page.has_content?('Plain text')
  end

  test 'loads html' do
    visit '/capybara'

    click_on 'htmlContent'

    assert page.has_content?('Will not be touched')
    assert page.has_no_content?('Pjax container')
    assert_equal page.find(:xpath, '//table/tbody/tr/td').text, 'Html content'
  end

  test 'fully reloads page' do
    visit '/capybara'

    click_on 'fullReload'

    assert page.has_no_content?('Will not be touched')
    assert page.has_content?('layouts/application Plain text')
  end

  test 'prevents pjax' do
    visit '/capybara'

    click_on 'preventsPjax'

    assert page.has_no_content?('Will not be touched')
    assert page.has_content?('layouts/application Prevents pjax')
  end
end
