class Hall < ApplicationRecord
  belongs_to :created_by, class_name: 'User'
  has_many :reservations

  validates :name, presence: true, length: { max: 255 }
  validates :capacity, presence: true, numericality: { only_integer: true }
  validates :cost, presence: true, numericality: true
  validates :image, presence: true, length: { max: 255 }
  validates :description, presence: true
end
