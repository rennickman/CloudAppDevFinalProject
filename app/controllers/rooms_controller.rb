class RoomsController < ApplicationController
    # Make sure user is logged in
    before_action :authenticate_user!

    def index
        # Set all rooms that are public
        @rooms = Room.public_rooms
        # Set all Users except current user
        @users = User.all_except(current_user)
    end
end
