class Reservation < ApplicationRecord
  belongs_to :hall
  belongs_to :user
end
