# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'user registration page' do
  before :each do
    visit register_path
  end

  describe 'user creation' do
    it 'has a form to create a new user' do
      ViewingPartyUser.delete_all
      ViewingParty.delete_all
      User.delete_all

      expect(page).to have_field('Name')
      expect(page).to have_field('Email')
      expect(page).to have_field("Password")
      expect(page).to have_field("Password Confirmation")
      expect(page).to have_button('Create New User')
    end

    it 'can be filled in and submitted' do
      fill_in('Name', with: 'Jeff Goldblum')
      fill_in('Email', with: 'JurassicSnark@gmail.com')
      fill_in('Password', with: "test_password")
      fill_in('Password Confirmation', with: "test_password")
      click_on 'Create New User'

      expect(current_path).to eq(user_path(User.last.id))

      expect(page).to have_content('Jeff Goldblum')
      expect(page).to have_content('User has been created!')
    end

    it 'returns an error if the email has an existing user' do
      fill_in('Name', with: 'Jeff Goldblum')
      fill_in('Email', with: 'JurassicSnark@gmail.com')
      fill_in('Password', with: "test_password")
      fill_in('Password Confirmation', with: "test_password")
      click_on 'Create New User'
      visit register_path

      fill_in('Name', with: 'John Doe')
      fill_in('Email', with: 'JurassicSnark@gmail.com')
      fill_in('Password', with: "test_password")
      fill_in('Password Confirmation', with: "test_password")
      click_on 'Create New User'

      expect(current_path).to eq(register_path)
      expect(page).to have_content('Email has already been taken')
    end

    it 'provides an appropriate error message when name is not filled in' do
      fill_in('Email', with: 'LifeFindsAWay@gmail.com')
      fill_in('Password', with: "test_password")
      fill_in('Password Confirmation', with: "test_password")
      click_on "Create New User"

      expect(current_path).to eq(register_path)
      expect(page).to have_content("Name can't be blank")
    end

    it 'provides an appropriate error message when password and confirmation do not match' do
      fill_in('Name', with: 'Jeff Goldblum')
      fill_in('Email', with: 'JurassicSnark@gmail.com')
      fill_in('Password', with: "test_password")
      fill_in('Password Confirmation', with: "I am Bad at This")
      click_on 'Create New User'

      expect(current_path).to eq(register_path)
      expect(page).to have_content("Password confirmation doesn't match Password")
    end
  end
end
