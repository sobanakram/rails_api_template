module Api
  module V1
    class SessionsController < DeviseTokenAuth::SessionsController
      protect_from_forgery with: :null_session
      include Api::Concerns::ActAsApiRequest

      api :POST, 'users/sign_in.json', 'User login'
      error 422, 'Unprocessable Entity'
      description 'Authorization not required, It will return access-token, client, uid in header, which required for authorization'
      param :email, String, required: true
      param :password, String, required: true
      returns code: 201, desc: "a successful response" do
        property :first_name, String
        property :last_name, String
        property :uid, String
        property :email, String
        property :user_type, String, 'Possible value: Parent, Student'
        property :device_token, String
        property :app_version, Integer
      end

      def create
        super
      end

      api :Delete, 'users/sign_out.json', 'Reader logout'

      def destroy
        # remove auth instance variables so that after_action does not run
        user = remove_instance_variable(:@resource) if @resource
        client = @token.client if @token.client
        @token.clear!

        if user
          user.tokens.clear
          user.save!
          render_destroy_success
        else
          render_destroy_error
        end
      end

      protected

      def render_create_success
        render json: @resource, serializer: CurrentUserSerializer
      end

      def render_create_error_bad_credentials
        render_error(422, I18n.t('devise_token_auth.sessions.bad_credentials'))
      end

      def render_create_error_account_locked
        render_account_blocked
      end

      def render_destroy_error
        render_error(422, I18n.t('devise_token_auth.sessions.user_not_found'))
      end

      private

      def resource_params
        params.permit(:email, :password)
      end

      def render_create_success
        render json: @resource
      end
    end
  end
end
