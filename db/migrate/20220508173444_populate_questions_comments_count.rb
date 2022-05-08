class PopulateQuestionsCommentsCount < ActiveRecord::Migration[7.0]
    def change
        Question.all.each do |question|
            Question.reset_counters(question.id, :comments)
        end
    end
end
