class User < ApplicationRecord
  has_secure_password

  has_many :hall, foreign_key: :created_by_id
  has_many :reservations
end
