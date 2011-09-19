module Pjax
  extend ActiveSupport::Concern
  
  included do
    alias_method :old_layout, :_layout
    layout ->(c) { pjax_request? ? false : c.send(:old_layout) }
    helper_method :pjax_request?
  end
  
  private  
    def redirect_pjax_to(action, url = nil)
      new_url = url_for(url ? url : { action: action })
      
      render js: <<-EJS
        if (!window.history || !window.history.pushState) {
          window.location.href = '#{new_url}';
        } else {
          $('[data-pjax-container]').html(#{render_to_string("#{action}.html.erb", layout: false).to_json});
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