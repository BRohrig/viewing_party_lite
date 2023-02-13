require 'rails_helper'

RSpec.describe "log in" do
  before(:each) do
    @user = create(:user, password: "this is only a test")
    visit login_path
  end

  it 'has a form to fill in with my unique email and password' do
    expect(page).to have_field :email
    expect(page).to have_field :password
    expect(page).to have_button("Log In")
  end

  it 'allows the user to log in with correct credentials' do
    fill_in :email, with: @user.email
    fill_in :password, with: @user.password
    click_button("Log In")

    expect(current_path).to eq(user_path(@user.id))
    expect(page).to have_content("Welcome #{@user.name}!")
  end

  it 'does not allow a login with invalid credentials' do
    fill_in :email, with: @user.email
    fill_in :password, with: "I am teh leetest haxxor"
    click_button("Log In")

    expect(current_path).to eq(login_path)
    expect(page).to have_content("Credentials Invalid.")
  end



end