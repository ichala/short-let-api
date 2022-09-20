class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :role, :email
  has_many :hall, dependent: :destroy
  has_many :reservations, dependent: :destroy
  
end
