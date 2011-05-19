module Pjax
  extend ActiveSupport::Concern
  
  included do
    layout lambda {|c| c.pjax_request? ? false : 'application' }
  end
  
  private  
    def redirect_pjax_to(action, url = nil)
      new_url = url_for(url ? url : { action => action })
      
      render :js, <<-EJS
        if (!window.history || !window.history.pushState) {
          window.location.href = '#{new_url}';
        } else {
          $('div.pages').html(#{render_to_string("#{action}.html.erb").to_json});
          $(document).trigger('end.pjax');

          var title = $.trim($('div.pages').find('title').remove().text());
          if (title) document.title = title;
          window.history.pushState({}, document.title, '#{new_url}');
        }
      EJS
    end

    def pjax_request?
      env['HTTP_X_PJAX'].present?
    end
end
