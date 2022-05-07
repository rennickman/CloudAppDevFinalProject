class Room < ApplicationRecord
    # Make sure name of chatroom is unique
    validates_uniqueness_of :name

    # Helper method for public rooms
    scope :public_rooms, -> { where(is_private: false) }
end
