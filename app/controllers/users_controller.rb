class UsersController < ApplicationController
    before_action :set_user

    def profile
    end


    def show
        # Set all users except current user
        @users = User.all_except(current_user)

        # Set all public rooms
        @room = Room.new
        @rooms = Room.public_rooms

        # Set name for new private room
        @room_name = get_name(@user, current_user)
        # Check if chatroom is already created or create a new chatroom
        @single_room = Room.where(name: @room_name).first || Room.create_private_room([@user, current_user], @room_name)

        @message = Message.new
        @messages = @single_room.messages.order(created_at: :asc)
        render 'rooms/index'
    end



    private

    # Method to set the User
    def set_user
        # Find User using Id from params
        @user = User.find(params[:id])
    end

    # Method for setting the name of private chatrooms
    def get_name(user1, user2)
        # Sort the user names so only one private room is creating if order is changed
        user = [user1, user2].sort
        "private_#{user[0].id}_#{user[1].id}"
    end
end
