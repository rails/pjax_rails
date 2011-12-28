module Pjax
  extend ActiveSupport::Concern
  
  included do
    layout ->(c) { pjax_request? ? false : 'application' }
    helper_method :pjax_request?
  end
  
  private  
    def redirect_pjax_to(action, url = nil, ext = nil)
      new_url = url_for(url ? url : { action: action })
      ext = ext.present? ? ext : "html"

      # Fixed: Don't hardcode .erb
      render js: <<-EJS
        if (!window.history || !window.history.pushState) {
          window.location.href = '#{new_url}';
        } else {
          $('[data-pjax-container]').html(#{render_to_string("#{action}.#{ext}", layout: false).to_json});
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
