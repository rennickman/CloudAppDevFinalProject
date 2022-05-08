class QuestionsController < ApplicationController
    before_action :set_question, only: %i[ show edit update destroy ]
     # Make sure user is logged in before accessing writings controller, except show and index
    before_action :authenticate_user!, except: %i[show index]

    # GET /questions or /questions.json
    def index
        @questions = Question.all
    end


    # GET /questions/1 or /questions/1.json
    def show
        # Grab the comments with newest first
        @comments = @question.comments.includes(:user, :rich_text_body).order(created_at: :desc)
        # Set the notifications that have been read
        mark_notifications_as_read
    end


    # GET /questions/new
    def new
        @question = Question.new
    end


    # GET /questions/1/edit
    def edit
    end


    # POST /questions or /questions.json
    def create
        @question = Question.new(question_params)
        # Save current user
        @question.user = current_user

        respond_to do |format|
            if @question.save
              format.html { redirect_to question_url(@question), notice: "Question was successfully created." }
              format.json { render :show, status: :created, location: @question }
            else
              format.html { render :new, status: :unprocessable_entity }
              format.json { render json: @question.errors, status: :unprocessable_entity }
            end
        end
    end


    # PATCH/PUT /questions/1 or /questions/1.json
    def update
        respond_to do |format|
            if @question.update(question_params)
              format.html { redirect_to question_url(@question), notice: "Question was successfully updated." }
              format.json { render :show, status: :ok, location: @question }
            else
              format.html { render :edit, status: :unprocessable_entity }
              format.json { render json: @question.errors, status: :unprocessable_entity }
            end
        end
    end


    # DELETE /questions/1 or /questions/1.json
    def destroy
        @question.destroy

        respond_to do |format|
            format.html { redirect_to questions_url, notice: "Question was successfully destroyed." }
            format.json { head :no_content }
        end
    end
    

    private


        # Use callbacks to share common setup or constraints between actions.
        def set_question
            @question = Question.find(params[:id])

            # Slug functionality to handle redirects if title changed
            redirect_to @question, status: :moved_permanently if params[:id] != @question.slug
            
        end

        # Only allow a list of trusted parameters through.
        def question_params
            params.require(:question).permit(:title, :body, :answer)
        end

        # Set notifications to read
        def mark_notifications_as_read
            # Check user is signed in
            if current_user
                # Set notifications to be marked as read
                notifications_to_mark_as_read = @question.notifications_as_question.where(recipient: current_user)
                # Update notifications read at time
                notifications_to_mark_as_read.update_all(read_at: Time.zone.now)
            end
        end

end
