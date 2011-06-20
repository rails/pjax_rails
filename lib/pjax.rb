module Pjax
  extend ActiveSupport::Concern
  
  included do
    before_filter lambda {      
      if pjax_request? 
        self.instance_eval do         
          @old_layout = self.send("_layout")
        end      
        self.class.send(:layout, false) 
      end
    }

    after_filter lambda {self.class.send(:layout, self.instance_variable_get(:@old_layout)) if pjax_request?}
  end
  
  private  
    def redirect_pjax_to(action, url = nil)
      new_url = url_for(url ? url : { action: action })
      
      render js: <<-EJS
        if (!window.history || !window.history.pushState) {
          window.location.href = '#{new_url}';
        } else {
          $('[data-pjax-container]').html(#{render_to_string("#{action}.html.erb").to_json});
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