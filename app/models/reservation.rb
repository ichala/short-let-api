class Reservation < ApplicationRecord
  belongs_to :hall
  belongs_to :user
  has_many :notifications
end
