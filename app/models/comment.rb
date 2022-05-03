class Comment < ApplicationRecord
    belongs_to :question
    belongs_to :user

    # Give the body Rich Text
    has_rich_text :body
end
