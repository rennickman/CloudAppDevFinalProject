class ApplicationController < ActionController::Base
    # Set notifications if User logged in
    before_action :set_notifications, if: :current_user
    before_action :set_query


    # Filter through Questions for Search Query
    def set_query
        @query = Question.ransack(params[:q])
    end



    private


    # Set notifications for User - read and unread
    def set_notifications
        # Grab the latest Notifications limited to 9
        notifications = Notification.includes(:recipient).where(recipient: current_user).newest_first.limit(9)
        # Set unread notifications
        @unread = notifications.unread
        # Set read notifications
        @read = notifications.read
    end

end
