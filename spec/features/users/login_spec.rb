require 'rails_helper'

RSpec.describe "log in" do
  before(:all) do
    @user = create(:user, password: "this is only a test")
    visit login_path
  end

  it 'has a form to fill in with my unique email and password' do
    expect(page).to have_field :email
    expect(page).to have_field :password
    expect(page).to have_button("Log In")
  end



end