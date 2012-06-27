module Pjax
  extend ActiveSupport::Concern

  included do
    layout proc { |c| pjax_request? ? pjax_layout : default_layout }
    helper_method :pjax_request?

    rescue_from Pjax::Unsupported, :with => :pjax_unsupported

    before_filter :strip_pjax_param, :if => :pjax_request?
    before_filter :set_pjax_url,     :if => :pjax_request?
  end

  class Error < StandardError; end
  class Unsupported < Error; end

  protected
    def pjax_request?
      request.env['HTTP_X_PJAX'].present?
    end

    def default_layout
      'application'
    end

    def pjax_layout
      false
    end

    def pjax_container
      return unless pjax_request?
      request.headers['X-PJAX-Container']
    end

    def pjax_unsupported
      head :not_acceptable
    end

    # Call in a before_filter or in an action to disable pjax on an action.
    #
    # Examples
    #
    #     before_filter :prevent_pjax!
    #
    #     def login
    #       prevent_pjax!
    #       # ...
    #     end
    #
    def prevent_pjax!
      raise Pjax::Unsupported if pjax_request?
    end

    def strip_pjax_param
      params.delete(:_pjax)
      request.env['QUERY_STRING'] = request.env['QUERY_STRING'].sub(/_pjax=[^&]+&?/, '')

      request.env.delete('rack.request.query_string')
      request.env.delete('rack.request.query_hash')
      request.env.delete('action_dispatch.request.query_parameters')

      request.instance_variable_set('@original_fullpath', nil)
      request.instance_variable_set('@fullpath', nil)
    end

    def set_pjax_url
      response.headers['X-PJAX-URL'] = request.url
    end
end
