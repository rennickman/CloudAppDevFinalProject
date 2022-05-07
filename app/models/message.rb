class Message < ApplicationRecord
    belongs_to :user
    belongs_to :room

    after_create_commit { broadcast_append_to room }
    before_create :confirm_participant



    # Check if someone is a participant if room is private
    def confirm_participant
        return unless room.is_private

        # Throw an abort if the user isnt a participant
        is_participant = Participant.where(user_id: user.id, room_id: room.id).first
        throw :abort unless is_participant
    end
end
