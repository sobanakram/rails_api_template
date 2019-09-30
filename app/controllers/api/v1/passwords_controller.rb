module Api
  module V1
    class PasswordsController < DeviseTokenAuth::PasswordsController
      protect_from_forgery with: :exception
      include Api::Concerns::ActAsApiRequest
      # skip_before_action :check_json_request, on: :edit
      skip_before_action :validate_redirect_url_param, only: [:create]

      api :POST, 'users/passwords.json', 'User Reset Password Step 1'
      error 422, 'Unprocessable Entity'
      description 'Authorization not required'
      param :email, String, required: true
      returns code: 200, desc: "a successful response" do
        property :message, String
        property :success, [true, false]
      end
      # this action is responsible for generating password reset tokens and
      # sending emails
      def create
        super
      end

      api :PUT, 'users/passwords.json', 'User Reset Password Step 3'
      error 422, 'Unprocessable Entity'
      description 'Authorization is required'
      param :password, String, required: true
      param :password_confirmation, String, required: true
      returns code: 200, desc: "a successful response" do
        property :message, String
        property :success, [true, false]
      end

      def update
        super
      end

      private

      def render_update_success
        render json: {
          success: true,
          message: I18n.t('devise_token_auth.passwords.successfully_updated')
        }
      end

      def render_code_not_valid_error
        render_error(422, I18n.t('devise.passwords.invalid_code'))
      end
    end
  end
end
