class Question < ApplicationRecord
    validates :title, presence: true, length:{ minimum:5, maximum:20 }
    validates :body, presence: true, length:{ minimum:5, maximum:35 }
    validates :answer, presence: true, length:{ minimum:5, maximum:35 }

    has_many :comments, dependent: :destroy
end
