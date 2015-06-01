require 'rails_helper'

RSpec.feature 'Admin::ManagingStates', type: :feature do
  before do
    load Rails.root + 'db/seeds.rb'
    sign_in_as!(FactoryGirl.create(:admin_user))
  end

  scenario 'Marking a state as default' do
    visit root_path
    click_link 'Admin'
    click_link 'States'
    # within '#state_New' do
    within state_line_for('New') do
      # find('td').text('Make Default Starting State').first.
      click_link('Make Default Starting State')
    end

    expect(page).to have_content 'New is now the default state.'
  end
end
