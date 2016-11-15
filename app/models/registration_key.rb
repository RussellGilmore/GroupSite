class RegistrationKey < ApplicationRecord
    validates :key,
              presence: true,
              uniqueness: true
end
