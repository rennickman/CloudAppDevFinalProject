class MessagesController < ApplicationController


    def create
        # Create new message using current user id and room id from params
        @message = current_user.messages.create(body: msg_params[:body], room_id: params[:room_id])
    end



    private


    def msg_params
        params.require(:message).permit(:body)
    end

end
