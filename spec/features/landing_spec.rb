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

  it 'has a link to log in with my unique credentials' do
    visit root_path

    within "#users" do
      expect(page).to have_link("Log In")
      click_link("Log In")
      expect(current_path).to eq(login_path)
    end
  end
end
