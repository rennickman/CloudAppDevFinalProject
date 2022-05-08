class Comment < ApplicationRecord
    belongs_to :question, counter_cache: true
    belongs_to :user

    # Give the body Rich Text
    has_rich_text :body

    # Send Notification + Clean Up
    after_create_commit :notify_recipient
    before_destroy :cleanup_notifications
    has_noticed_notifications model_name: "Notification"



    private

    # Send a notification
    def notify_recipient
        CommentNotification.with(comment: self, question: question).deliver_later(question.user)
    end

    # Delete All notifcations
    def cleanup_notifications
        notifications_as_comment.destroy_all
    end
end
