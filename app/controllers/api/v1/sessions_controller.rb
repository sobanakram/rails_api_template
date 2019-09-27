module Api
  module V1
    class SessionsController < DeviseTokenAuth::SessionsController
      protect_from_forgery with: :null_session
      include Api::Concerns::ActAsApiRequest

      api :POST, 'users/sign_in.json', 'User login'
      error 422, 'Unprocessable Entity'
      description 'Authorization not required, It will return access-token, client, uid in header, which required for authorization'
      param :user, Hash, desc: "User info", required: true do
        param :email, String, required: true
        param :password, String, required: true
      end
      returns code: 201, desc: "a successful response" do
        property :uid, String
        property :email, String
        property :user_type, String, 'Possible value: Parent, Student'
        property :device_token, String
        property :app_version, Integer
      end

      def create
        super
      end

      api :Delete, 'users/sign_out.json', 'User logout'
      description ''

      def destroy
        super
      end

      private

      def resource_params
        params.require(:user).permit(:email, :password)
      end

      def render_create_success
        render json: @resource
      end
    end
  end
end
