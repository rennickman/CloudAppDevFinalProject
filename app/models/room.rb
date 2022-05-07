class Room < ApplicationRecord
    # Make sure name of chatroom is unique
    validates_uniqueness_of :name

    # Helper method for public rooms
    scope :public_rooms, -> { where(is_private: false) }
    # Broadcast new Room to list of Rooms in Chatroom
    after_create_commit { broadcast_append_to 'rooms' }

    has_many :messages
end
