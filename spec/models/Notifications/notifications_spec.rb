require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe 'Notification model' do
    user = User.create(first_name: 'Test', last_name: 'Test', email: 'test@example.com', password: 'lakaka12')
    subject { Notification.new(text: 'Test', reserve_id: 1, recipient_id: user.id, admin_id: user.id) }

    it 'should check if the text is not blank' do
      subject.text = nil
      expect(subject).to_not be_valid
    end

    it 'should check if the reserve_id is not blank' do
      subject.reserve_id = nil
      expect(subject).to_not be_valid
    end

    it 'should check if the recipient_id is not blank' do
      subject.recipient_id = nil
      expect(subject).to_not be_valid
    end

    it 'should check if the admin_id is not blank' do
      subject.admin_id = nil
      expect(subject).to_not be_valid
    end
  end
end
