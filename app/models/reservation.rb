class Reservation < ApplicationRecord
  belongs_to :hall
  belongs_to :user
  has_many :notifications, class_name: 'Notification', foreign_key: :reserve_id, dependent: :destroy
  validates :reserve_date, presence: true
  validates :status, presence: true, length: { maximum: 20 }
end
