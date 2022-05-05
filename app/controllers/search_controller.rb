class SearchController < ApplicationController

  
    def index
        # Filter through Questions for Search Query
        @query = Question.ransack(params[:q])
        # Set all distinct results
        @questions = @query.result(distinct: true)
    end
end
