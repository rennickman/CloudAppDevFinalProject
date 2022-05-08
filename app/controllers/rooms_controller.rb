class RoomsController < ApplicationController
    # Make sure user is logged in
    before_action :authenticate_user!
    # Set user status
    before_action :set_status

    def index
        @room = Room.new
        # Set all rooms that are public
        @rooms = Room.public_rooms

        # Set all Users except current user
        @users = User.all_except(current_user)

        # Render index page without selected chatroom
        render 'index'
    end


    def show
        # Set Selected Room
        @single_room = Room.find(params[:id])

        @room = Room.new
        # Set all rooms that are public
        @rooms = Room.public_rooms


        @message = Message.new
        # Set all the messages for selected room
        @messages = @single_room.messages.order(created_at: :asc)

        # Set all Users except current user
        @users = User.all_except(current_user)
        # Render index page with selected chatroom
        render 'index'
    end


    def create
        # create a new room using params
        @room = Room.create(name: params["room"]["name"])
    end




    private


    # Set User as online when they visit rooms pages
    def set_status
        current_user.update!(status: User.statuses[:online]) if current_user
    end
end
