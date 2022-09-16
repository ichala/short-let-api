class User < ApplicationRecord
  has_secure_password

  has_many :hall, foreign_key: :created_by_id, dependent: :delete_all
  has_many :reservations, dependent: :delete_all
  has_many :notified, class_name: 'Notification', foreign_key: :recipient_id, dependent: :delete_all
  has_many :notifier, class_name: 'Notification', foreign_key: :admin_id, dependent: :delete_all

  validates :first_name, presence: true, length: { max: 255 }
  validates :last_name, presence: true, length: { max: 255 }
  validates :email, presence: true, length: { max: 255 }
end
