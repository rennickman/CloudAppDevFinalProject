class UsersController < ApplicationController
    before_action :set_user

    def profile
    end



    private

    # Method to set the User
    def set_user
        # Find User using Id from params
        @user = User.find(params[:id])
    end
end
