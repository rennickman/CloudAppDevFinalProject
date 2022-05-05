class Writing < ApplicationRecord
    validates :title, presence: true, length:{ minimum:5, maximum:20 }
    validates :body, presence: true, length:{ minimum:5, maximum:35 }
    
    belongs_to :user
end
