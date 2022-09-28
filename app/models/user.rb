class User < ApplicationRecord
  has_secure_password

  has_many :hall, foreign_key: :created_by_id, dependent: :destroy
  has_many :reservations, dependent: :destroy
  has_many :notified, class_name: 'Notification', foreign_key: :recipient_id, dependent: :destroy
  has_many :notifier, class_name: 'Notification', foreign_key: :admin_id, dependent: :destroy

  validates :first_name, presence: true, length: { maximum: 255 }
  validates :last_name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, length: { maximum: 255 }
  validates :email, uniqueness: true
end
