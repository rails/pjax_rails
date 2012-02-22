module Pjax
  extend ActiveSupport::Concern

  included do
    layout proc { |c| pjax_request? ? pjax_layout : 'application' }
    helper_method :pjax_request?
    around_filter :set_pjax_url
  end

  protected
    def pjax_request?
      env['HTTP_X_PJAX'].present?
    end

    def pjax_layout
      false
    end

    def set_pjax_url
      yield
      response.headers['X-PJAX-URL'] = request.url
    end

  private
    def redirect_pjax_to(action, url = nil)
      new_url = url_for(url ? url : { :action => action })

      render :js => <<-EJS
        if (!window.history || !window.history.pushState) {
          window.location.href = '#{new_url}';
        } else {
          $('[data-pjax-container]').html(#{render_to_string("#{action}.html.erb", :layout => false).to_json});
          $(document).trigger('end.pjax');

          var title = $.trim($('[data-pjax-container]').find('title').remove().text());
          if (title) document.title = title;
          window.history.pushState({}, document.title, '#{new_url}');
        }
      EJS
    end
end
