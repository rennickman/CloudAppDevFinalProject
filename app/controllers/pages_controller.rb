class PagesController < ApplicationController
    # Set status of user
    after_action :set_status


    def home
    end

    def about
    end



    private


    # Method for setting status of user as offline when on home page
    def set_status
        current_user.update!(status: User.statuses[:offline]) if current_user
    end
end
