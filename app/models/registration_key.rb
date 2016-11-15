class RegistrationKey < ApplicationRecord
    has_secure_token :key
    validates :key,
              uniqueness: true
end
