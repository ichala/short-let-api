class Reservation < ApplicationRecord
  belongs_to :hall
  belongs_to :user
  has_many :notifications

  validates :reserve_date, presence: true
  validates :status, presence: true, length: { max: 20 }
end
