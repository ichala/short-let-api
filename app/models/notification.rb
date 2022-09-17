class Notification < ApplicationRecord
  belongs_to :reservation,class_name: 'Reservation', foreign_key: :reserve_id
  belongs_to :recipient, class_name: 'User'
  belongs_to :admin, class_name: 'User'
  validates :text, presence: true
end
