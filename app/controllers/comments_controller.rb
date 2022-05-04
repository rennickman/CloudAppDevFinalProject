class CommentsController < ApplicationController
    # Check User is Logged In
    before_action :authenticate_user!
    before_action :set_question

    # Create a new comment
    def create
        # Create new comment
        @comment = @question.comments.create(comment_params)
        # Add current User to the comment
        @comment.user = current_user

        # If comment is saved - flash notice and redirect back to Question path
        if @comment.save
            flash[:notice] = "Comment has been created"
            redirect_to question_path(@question)
        else
            flash[:notice] = "Comment has not been created"
            redirect_to question_path(@question)
        end
    end


    # Destroy a comment
    def destroy
        # Find the comment using the id in params
        @comment = @question.comments.find(params[:id])
        # Destroy the comment
        @comment.destroy
        # Redirect back to question
        redirect_to question_path(@question)
    end


    # Edit a comment
    def update
        # Find the comment using the id in params
        @comment = @question.comments.find(params[:id])

        # Update Comment using params and redirect back to Question page
        respond_to do |format|
            if @comment.update(comment_params)
                format.html { redirect_to question_url(@question), notice: "Comment has been updated" }
            else 
                format.html { redirect_to question_url(@question), alert: "Comment was not updated" }
            end
        end
    end



    private

    # Set the Question
    def set_question
         # Find the Question using the ID in params
        @question = Question.find(params[:question_id])
    end


    # Params Allowed For Comment
    def comment_params
        params.require(:comment).permit(:body)
    end
    
end
