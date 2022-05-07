class Room < ApplicationRecord
    # Make sure name of chatroom is unique
    validates_uniqueness_of :name

    # Helper method for public rooms
    scope :public_rooms, -> { where(is_private: false) }
    # Broadcast new Room to list of Rooms in Chatroom if Public
    after_create_commit { broadcast_if_public }

    has_many :messages
    has_many :participants, dependent: :destroy



    # Method to check if room is public and should be broadcasted
    def broadcast_if_public
        broadcast_append_to 'rooms' unless self.is_private
    end


    # Method for creating participants of private rooms
    def self.create_private_room(users, room_name) 
        # Set room as private
        single_room = Room.create(name: room_name, is_private: true)
        # Create a participant for each user
        users.each do |user|
            Participant.create(user_id: user.id, room_id: single_room.id)
        end
        single_room
    end


    # Method to check if a user if a participant of a room
    def participant?(room, user)
        room.participants.where(user: user).exists?
    end

end
