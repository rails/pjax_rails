module Pjax
  extend ActiveSupport::Concern

  included do
    layout proc { |c| pjax_request? ? pjax_layout : 'application' }
    helper_method :pjax_request?
  end

  protected
    def pjax_layout
      false
    end

  private
    def redirect_pjax_to(action, url = nil)
      new_url = url_for(url ? url : { action: action })

      render js: <<-EJS
        if (!window.history || !window.history.pushState) {
          window.location.href = '#{new_url}';
        } else {
          $('[data-pjax-container]').html(#{render_to_string("#{action}.html.erb", layout: false).to_json});
          $(document).trigger('pjax:end');

          var title = $.trim($('[data-pjax-container]').find('title').remove().text());
          if (title) document.title = title;
          window.history.pushState({}, document.title, '#{new_url}');
        }
      EJS
    end

    def pjax_request?
      env['HTTP_X_PJAX'].present?
    end
end
