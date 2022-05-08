class AdminController < ApplicationController

  
    def index
    end

    def writings
        # Set all the writings
        @writings = Writing.all.includes(:user)
    end

    def questions
        # Set all the questions with comments included
        @questions = Question.all.includes(:user)
    end

    def comments
    end

    def users
    end

    def show_writing
        # Set Writing using Id in params
        @writing = Writing.includes(:user).find(params[:id])
    end

    def show_question
        # Set question using Id in params
        @question = Question.includes(:user).find(params[:id])
    end
end
