require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.create!(first_name: 'Admin', last_name: 'Admin', email: 'admin@admin.com', password: 'admin123') }
  before { subject.save }

  it 'first_name should be present' do
    subject.first_name = nil
    expect(subject).to_not be_valid
  end

  it 'last_name should be present' do
    subject.last_name = nil
    expect(subject).to_not be_valid
  end

  it 'role should be user by default' do
    expect(subject.role).to eq('user')
  end

  it 'email should be present' do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it 'password should be present' do
    subject.password = nil
    expect(subject).to_not be_valid
  end
end
