class ApplicationController < ActionController::Base

    before_action :set_notifications, if: :current_user



    private

    # Set notifications for User - read and unread
    def set_notifications
        # Grab the latest Notifications limited to 9
        notifications = Notification.where(recipient: current_user).newest_first.limit(9)
        # Set unread notifications
        @unread = notifications.unread
        # Set read notifications
        @read = notifications.read
    end

end
