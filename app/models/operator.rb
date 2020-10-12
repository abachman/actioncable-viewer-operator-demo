class Operator < ApplicationRecord
  has_secure_password

  has_many :chat_sessions
end
