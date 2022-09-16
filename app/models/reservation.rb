class Reservation < ApplicationRecord
  belongs_to :hall
  belongs_to :user
  has_many :notifications, dependent: :delete_all

  validates :reserve_date, presence: true
  validates :status, presence: true, length: { maximum: 20 }
end
