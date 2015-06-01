require 'rails_helper'

RSpec.feature 'LandingPages', type: :feature do
  scenario 'Guest welcomed with a landing page' do
    visit root_path
    expect(page.body).to have_content('ProjectRobin')
    expect(page.body).to have_content('A simple project management helper')
  end
end
