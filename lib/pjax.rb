module Pjax
  extend ActiveSupport::Concern
  
  included do
    layout ->(c) { pjax_request? ? false : 'application' }
    helper_method :pjax_request?
  end
  
  private  
    def redirect_pjax_to(action, url = nil, render_js = false)
      new_url = url_for(url ? url : { action: action })

      # Fixed: Don't hardcode .erb
      render js: <<-EJS
        if (!window.history || !window.history.pushState) {
          window.location.href = '#{new_url}';
        } else {
          #{render_js ? render_to_string(action.to_s+".js") : nil}
          $('[data-pjax-container]').html(#{render_to_string("#{action}.html", layout: false).to_json});
          $(document).trigger('end.pjax');

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
