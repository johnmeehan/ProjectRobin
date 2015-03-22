require 'rails_helper'

RSpec.feature "SigningUps", type: :feature do
  scenario "Successful sign up" do
    visit root_path
    click_link 'Sign up'
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"

    expect(page).to have_content("You have signed up successfully.")
    expect(User.find_by(email: 'user@example.com')).to be_admin
  end
end
