require 'rails_helper'

RSpec.describe User do
  describe 'relationships' do
    it { should have_many(:viewing_parties).through(:viewing_party_users) }
    it { should have_many(:viewing_party_users) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :password_digest }
    it { should have_secure_password }
  end

  it 'can get the user name with email' do
    user = create(:user, password: "test_password")

    expect(user.name_with_email).to eq("#{user.name} #{user.email}")
    expect(user).to_not have_attribute(:password)
    expect(user.password_digest).to_not eq("test_password")
  end
end
