module Api
  module V1
    class PasswordsController < DeviseTokenAuth::PasswordsController
      protect_from_forgery with: :exception
      include Api::Concerns::ActAsApiRequest
      # skip_before_action :check_json_request, on: :edit
      skip_before_action :validate_redirect_url_param, only: [:create]

      api :POST, 'users/verify_code.json', 'User Reset Password Step 2'
      error 422, 'Unprocessable Entity'
      description 'Authorization not required, It will return access-token, client, uid in header, which required for authorization'
      param :email, String, required: true
      param :reset_password_token, String, required: true
      returns code: 200, desc: "a successful response" do
        property :success, [true, false]
      end

      def verify_code
        return render_create_error_missing_email unless resource_params[:email]

        @email = get_case_insensitive_field_from_resource_params(:email)
        @resource = find_resource(:uid, @email)

        if @resource
          return render_code_not_valid_error unless @resource.valid_code?(resource_params[:reset_password_token])
          # allow user to change password once without current_password

          @resource.allow_password_change = true if recoverable_enabled?
          @resource.save!
          if @resource.errors.empty?
            sign_in(:user, @resource, store: false, bypass: false)
            render json: {
              success: true
            }
          else
            render_create_error @resource.errors
          end
        else
          render_not_found_error
        end
      end

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
        return render_create_error_missing_email unless resource_params[:email]

        @email = get_case_insensitive_field_from_resource_params(:email)
        @resource = find_resource(:uid, @email)

        if @resource
          @resource.ask_reset_password
          if @resource.errors.empty?
            return render_create_success
          else
            render_error(422, @resource.errors)
          end
        else
          render_error(404, I18n.t('devise_token_auth.passwords.user_not_found', email: @email))
        end
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
