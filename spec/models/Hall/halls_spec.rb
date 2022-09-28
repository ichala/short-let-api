require 'rails_helper'

RSpec.describe Hall, type: :model do
  describe 'Hall model' do
    @user = User.create(first_name: 'Test', last_name: 'Test', email: 'test@user.com', password: 'lakaka12')
    subject { Hall.new(name: 'Hall1', capacity: 200, cost: 100, image: 'https://testimage', description: 'First Hall', created_by_id: @user) }
    before { subject.save }

    it 'should check if the name is not blank' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'should check if the capacity is not blank' do
      subject.capacity = nil
      expect(subject).to_not be_valid
    end

    it 'should checks if the cost is not empty' do
      subject.cost = nil
      expect(subject).to_not be_valid
    end

    it 'should checks if the image is not empty' do
      subject.image = nil
      expect(subject).to_not be_valid
    end

    it 'should checks if the description is not empty' do
      subject.description = nil
      expect(subject).to_not be_valid
    end
  end
end
