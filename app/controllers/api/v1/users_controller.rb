module Api
  module V1
    class UsersController < Api::V1::ApiController

      api :GET, 'user/profile.json', 'User Profile'
      returns code: 200, desc: "a successful response" do
        property :uid, String
        property :email, String
        property :device_token, String
        property :app_version, Integer
      end

      def profile
        render json: current_user
      end
    end
  end
end
