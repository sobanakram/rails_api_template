module Api
  module V1
    class RegistrationsController < DeviseTokenAuth::RegistrationsController
      protect_from_forgery with: :exception
      include Api::Concerns::ActAsApiRequest

      api :POST, 'users.json', 'User Sign Up'
      error 422, 'Unprocessable Entity'
      description 'Authorization not required, It will return access-token, client, uid in header, which required for authorization'
      param :first_name, String, required: true
      param :last_name, String, required: true
      param :email, String, required: true
      param :password, String, required: true
      param :password_confirmation, String, required: true
      param :device_token, String, required: true
      param :app_version, Integer, required: true

      returns code: 201, desc: "a successful response" do
        property :uid, String
        property :email, String
        property :device_token, String
        property :app_version, Integer
      end

      def create
        super
      end

      private

      def sign_up_params
        params.permit(:first_name, :last_name, :email, :password, :password_confirmation, :device_token, :app_version)
      end

      def render_create_success
        render json: @resource
      end

      def render_create_error
        render json: {
          status: 'error',
          error: resource_errors[:full_messages].join(', ')
        }, status: 422
      end
    end
  end
end
