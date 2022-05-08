class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

    # Helper function so user cant direct message themselves
    scope :all_except, ->(user) { where.not(id: user) }
    # Broadcast new User to list of Users in Chatroom
    after_create_commit { broadcast_append_to 'users' }

    after_update_commit { broadcast_update }

    has_many :questions, dependent: :destroy
    has_many :writings, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :messages

    has_many :notifications, as: :recipient, dependent: :destroy

    has_one_attached :avatar
    after_commit :add_default_avatar, on: %i[create update]

    # Admin and User Roles
    enum role: [:user, :admin]
    after_initialize :set_default_role, if: :new_record?

    # Online Statuses
    enum status: %i[offline away online]




    # Create thumbnail of the avatar
    def avatar_thumbnail
        avatar.variant(resize_to_limit: [150, 150]).processed
    end


    # Create small version of avatar for chat
    def chat_avatar
        avatar.variant(resize_to_limit: [50, 50]).processed
    end


    # Broadcast any changes to user status
    def broadcast_update
        broadcast_append_to 'user_status', partial: 'users/status', user: self
    end



    # Change CSS styling depending on status
    def status_to_css
        case status
        when 'online'
            'bg-success'
        when 'away'
            'bg-warning'
        when 'offline'
            'bg-dark'
        else
            'bg-dark'
        end
    end





    private



    # Set Default role of newly created accounts as User unless set as admin
    def set_default_role
        self.role ||= :user
    end




    # Default Avatar when account created or updated
    def add_default_avatar
        # Check if avatar already attached
        return if avatar.attached?

        # Attach default avatar
        avatar.attach(
            io: File.open(Rails.root.join('app', 'assets', 'images', 'default_profile.jpg')),
            filename: 'default_profile.jpg',
            content_type: 'image/jpg'
        )
    end
end
