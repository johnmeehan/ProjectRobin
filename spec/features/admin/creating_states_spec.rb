require 'rails_helper'

RSpec.feature 'Creating States', type: :feature do
  before do
    sign_in_as!(FactoryGirl.create(:admin_user))
  end

  scenario 'Creating a state' do
    click_link 'Admin'
    click_link 'States'
    click_link 'New State'
    fill_in 'Name', with: 'Duplicate'
    click_button 'Create State'
    expect(page).to have_content('State has been created.')
  end

  scenario 'Making a new State with colour' do
    click_link 'Admin'
    click_link 'States'
    click_link 'New State'
    fill_in 'Name', with: 'HOLD'
    fill_in 'Background', with: 'blue'
    fill_in 'Color', with: 'red'
    click_button 'Create State'

    expect(page).to have_css '.state_hold'
    expect(page).to have_text 'HOLD'
  end

  scenario 'Edit a State' do
    FactoryGirl.create(:state)

    click_link 'Admin'
    click_link 'States'
    within('#states') do
      click_link('Edit', match: :first)
    end
    fill_in 'Name', with: 'HOLD2'
    fill_in 'Background', with: 'yellow'
    fill_in 'Color', with: 'green'
    click_button 'Update State'

    expect(page).to have_css '.state_hold2'
    expect(page).to have_text 'HOLD2'
  end
end
