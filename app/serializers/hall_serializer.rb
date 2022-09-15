class HallSerializer < ActiveModel::Serializer
  attributes :id, :name, :capacity, :cost, :image, :description
end
