class HallSerializer < ActiveModel::Serializer
  attributes :id, :name, :capacity, :cost, :image, :description
  has_many :reservations
end
