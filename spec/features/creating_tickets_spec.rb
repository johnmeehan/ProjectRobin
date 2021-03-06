
require 'rails_helper'

RSpec.feature 'CreatingTickets', type: :feature do
  before do
    project = FactoryGirl.create(:project)
    user = FactoryGirl.create(:user)
    state = FactoryGirl.create(:state, name: 'New', default: true)

    define_permission!(user, 'view', project)
    define_permission!(user, 'create tickets', project)
    @email = user.email
    sign_in_as!(user)
    visit projects_path
    click_link project.name
    click_link 'New Ticket'
  end

  scenario 'Creating a Ticket' do
    fill_in 'Title', with: 'Non-standards compliance'
    fill_in 'Description', with: 'My pages are ugly!'
    click_button 'Create Ticket'
    expect(page).to have_content('Ticket has been created.')
    within '#ticket #author' do
      expect(page).to have_content("Created by #{@email}")
    end
    within '.state' do
      expect(page).to have_content('New')
    end
  end

  scenario 'Creating a ticket without valid attributes fails' do
    click_button 'Create Ticket'
    expect(page).to have_content('Ticket has not been created.')
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Description can't be blank")
  end

  scenario 'Description must be longer than 10 characters' do
    fill_in 'Title', with: 'Non-standards compliance'
    fill_in 'Description', with: 'it sucks'
    click_button 'Create Ticket'

    expect(page).to have_content('Ticket has not been created.')
    expect(page).to have_content('Description is too short')
  end

  scenario 'Create tickets with an attachment' do
    # FIXME: issue with sass-rails and compiling embedded erb, so I took out the js bits.
    fill_in 'Title', with: 'Add documentation for blink tag'
    fill_in 'Description', with: 'The blink tag has a speed attribute'

    attach_file 'File #1', Rails.root.join('spec/fixtures/speed.txt')
    # click_link "Add another file"
    # attach_file 'File #2', Rails.root.join("spec/fixtures/spin.txt")
    click_button 'Create Ticket'

    expect(page).to have_content 'Ticket has been created.'

    # within("#ticket .assets") do
    within('.assets') do
      expect(page).to have_content 'speed.txt'
      # expect(page).to have_content 'spin.txt'
    end
  end
end
