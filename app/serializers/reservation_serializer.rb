class ReservationSerializer < ActiveModel::Serializer
  attributes :id, :hall_id, :reserve_date, :user_id, :status
  belongs_to :user
  belongs_to :hall
end
