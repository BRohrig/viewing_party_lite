# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Application' do
  it 'has a link to create a new user' do
    visit root_path
    expect(page).to have_content('Viewing Party')
    expect(page).to have_button('Create a New User')

    click_on('Create a New User')
    expect(current_path).to eq('/register')
  end

  it 'has a link back to landing page' do
    visit root_path
    expect(page).to have_link('Home')

    click_link('Home')
    expect(current_path).to eq(root_path)
  end

  it 'has a list of user emails displayed' do
    user = create(:user)
    user2 = create(:user)
    user3 = create(:user)
    user4 = create(:user)
    visit root_path

    within "#user_list" do
      expect(page).to have_content(user.email)
      expect(page).to have_content(user2.email)
      expect(page).to have_content(user3.email)
      expect(page).to have_content(user4.email)
    end
  end

  it 'has a link to log in with my unique credentials' do
    visit root_path

    within "#user_login" do
      expect(page).to have_link("Log In")
      click_link("Log In")
      expect(current_path).to eq(login_path)
    end
  end

  describe "session/logout" do
    before(:each) do
      @user = create(:user, password: "testing")
      visit login_path
      fill_in :email, with: @user.email
      fill_in :password, with: "testing"
      click_button("Log In")
    end

    it 'no longer displays links to log in or create account if i am already logged in, and instead has a logout button' do
      expect(current_path).to eq(user_path(@user.id))
      visit root_path
      expect(page).to_not have_link("Log In")
      expect(page).to_not have_button("Create a New User")
      expect(page).to have_link("Log Out")
    end

    it 'deletes the session and user_id and returns to landing page after log out' do
      visit root_path
      click_link("Log Out")
      expect(current_path).to eq(root_path)
      expect(page).to have_content("Logged Out Successfully")
      expect(page).to_not have_link("Log Out")
      expect(page).to have_button("Create a New User")
      expect(page).to have_link("Log In")
    end
  end
end
