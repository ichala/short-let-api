require 'rails_helper'

RSpec.describe Reservation, type: :model do
  @user = User.create(first_name: 'Eid', last_name: 'Hachem',role: "admin", email: 'test@test.com', password: '123456')
  @hall = Hall.create(name: 'Main', capacity: 100, cost: 50.5, image: 'https://testimage', description: 'Small', created_by_id: @user.id)
  subject { Reservation.new(reserve_date: Date.new, status: 'Pending', user_id: @user, hall_id: @hall) }
  before { subject.save }

  it 'reservation date should be present' do
    subject.reserve_date = nil
    expect(subject).to_not be_valid
  end

  it 'reservation status should be present' do
    subject.status = nil
    expect(subject).to_not be_valid
  end

  it 'reservation status should not be more than 20 characters' do
    subject.status = 'a' * 21
    expect(subject).to_not be_valid
  end
end