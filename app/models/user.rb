class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

    has_many :questions, dependent: :destroy
    has_many :writings, dependent: :destroy
    has_many :comments, dependent: :destroy

    has_many :notifications, as: :recipient, dependent: :destroy

    enum role: [:user, :admin]
    after_initialize :set_default_role, if: :new_record?



    private

    # Set Default role of newly created accounts as User unless set as admin
    def set_default_role
        self.role ||= :user
    end
end
