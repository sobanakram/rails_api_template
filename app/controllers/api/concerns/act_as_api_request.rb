module Api
  module Concerns
    module ActAsApiRequest
      extend ActiveSupport::Concern

      included do
        skip_before_action :verify_authenticity_token
        before_action :skip_session_storage
        before_action :check_json_request
      end

      def check_json_request
        return if request.format.json?

        render json: { error: I18n.t('api.errors.invalid_content_type') }, status: :not_acceptable
      end

      def skip_session_storage
        # Devise stores the cookie by default, so in api requests, it is disabled
        # http://stackoverflow.com/a/12205114/2394842
        request.session_options[:skip] = true
      end

      def render_resource(resource, status = 201)
        render json: resource, status: status
      end

      def render_resource_error(resource, status = 422)
        render_error(status, resource.errors.full_messages.join(', '))
      end

      def render_message(message, status = 200)
        response = {
          message: message
        }
        render json: response, status: status
      end

      def render_error(status, message, _data = nil)
        response = {
          error: message
        }
        render json: response, status: status
      end

      def render_account_blocked
        render_error(401, I18n.t('devise.sessions.blocked'))
      end

      def request_content_type
        request.content_type
      end

      def pagy_meta(pagy)
        pagy_headers(pagy).except("Link")
      end
    end
  end
end
