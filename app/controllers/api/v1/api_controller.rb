module Api
  module V1
    class ApiController < ApplicationController
      include Api::Concerns::ActAsApiRequest
      include DeviseTokenAuth::Concerns::SetUserByToken

      before_action :authenticate_user!, except: :status
      before_action :user_blocked!

      serialization_scope :view_context

      layout false
      respond_to :json

      rescue_from Exception,                           with: :render_exception_error
      rescue_from ActiveRecord::RecordNotFound,        with: :render_not_found
      rescue_from ActiveRecord::RecordInvalid,         with: :render_record_invalid
      rescue_from ActionController::RoutingError,      with: :render_not_found
      rescue_from AbstractController::ActionNotFound,  with: :render_not_found
      rescue_from ActionController::ParameterMissing,  with: :render_parameter_missing
      rescue_from ArgumentError,                       with: :render_argument_error


      def status
        render json: { online: true }
      end

      private

      def render_exception_error(exception)
        raise exception if Rails.env.test?

        # To properly handle RecordNotFound errors in views
        return render_not_found(exception) if exception.cause.is_a?(ActiveRecord::RecordNotFound)

        logger.error(exception) # Report to your error managment tool here

        return if performed?

        render json: { error: I18n.t('api.errors.server') }, status: :internal_server_error
      end

      def render_not_found(exception)
        logger.info(exception) # for logging
        render json: { error: I18n.t('api.errors.not_found') }, status: :not_found
      end

      def render_record_invalid(exception)
        logger.info(exception) # for logging
        render json: { errors: exception.record.errors.as_json }, status: :bad_request
      end

      def render_parameter_missing(exception)
        logger.info(exception) # for logging
        render json: { error: I18n.t('api.errors.missing_param') }, status: :unprocessable_entity
      end

      def render_argument_error(exception)
        logger.info(exception) # for logging
        render_error(:bad_request, exception.message)
      end

      def user_blocked!
        render_account_blocked if current_user&.blocked?
      end
    end
  end
end
