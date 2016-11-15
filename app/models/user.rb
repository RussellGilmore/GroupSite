class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable,
           :confirmable, :lockable, :timeoutable,
           :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

    # Add a virtual attribute for authenticating by either username or email
    # This field is not persisted. It is only used in controllers and views.
    attr_accessor :login

    # Maps the data from the OAuth response to the User model
    def self.from_omniauth(auth)
        username = auth.info.email.split(/@/)[0]
        already_used = User.where(username: username).first
        username = auth.info.email if already_used
        where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
            user.username = username
            user.email = auth.info.email
            user.password = Devise.friendly_token[0, 20]
        end
    end

    # override find_first_by_auth_conditions to allow authentication via email or username
    def self.find_first_by_auth_conditions(warden_conditions)
        conditions = warden_conditions.dup
        if login = conditions.delete(:login)
            where(conditions).where(['lower(username) = :value OR lower(email) = :value', { value: login.downcase }]).first
        else
            if conditions[:username].nil?
                where(conditions).first
            else
                where(username: conditions[:username]).first
            end
        end
    end

    validates :username,
              presence: true,
              uniqueness: {
                  case_sensitive: false
              }
    # Only allow letter, number, underscore and punctuation.
    # validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, multiline: true
end
