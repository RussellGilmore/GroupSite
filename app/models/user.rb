class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable,
           :confirmable, :lockable, :timeoutable,
           :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

    validates :username,
              presence: true,
              uniqueness: {
                  case_sensitive: false
              }
    validates :registration_key,
              on: :create,
              presence: true
    validate :registration_key_exists, on: :create

    # Only allow letter, number, underscore and punctuation.
    # validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, multiline: true

    after_create :delete_registration_key

    # Add a virtual attribute for authenticating by either username or email
    # This field is not persisted. It is only used in controllers and views.
    attr_accessor :login
    attr_accessor :registration_key

    has_many :messages

    # Maps the data from the OAuth response to the User model
    def self.from_omniauth(auth)
        where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
            user.username = auth.info.nickname if auth.info.nickname
            user.email = auth.info.email
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

    # validates that the registration key exists.
    def registration_key_exists
        key = RegistrationKey.find_by_key registration_key
        errors.add(:registration_key, 'is not a valid registration key') unless key
    end

    # Removes the registration key after_create to prevent reuse
    def delete_registration_key
        key = RegistrationKey.find_by_key registration_key
        key.destroy if key
    end
end
