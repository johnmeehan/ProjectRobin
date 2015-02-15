require 'rails_helper'

RSpec.feature "Creating Comments", type: :feature do
	let!(:user){ FactoryGirl.create :user }
	let!(:project){ FactoryGirl.create :project}
	let!(:ticket){ FactoryGirl.create( :ticket, project: project, user: user) }
	before do
	  define_permission!(user, "view", project)
	  sign_in_as!(user)
	  visit root_path
	  click_link project.name
	end

	scenario 'Creating an invalid comment' do
	  click_link ticket.title
	  click_button 'Create Comment'
	  expect(page).to have_content "Comment has not been created."
	  expect(page).to have_content("Text can't be blank")
	end

end
