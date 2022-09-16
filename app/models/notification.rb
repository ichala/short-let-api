class Notification < ApplicationRecord
  belongs_to :reservation
  belongs_to :recipient, class_name: 'User'
  belongs_to :admin, class_name: 'User'
end
