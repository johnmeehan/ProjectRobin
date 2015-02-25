require 'rails_helper'

RSpec.feature "Creating Comments", type: :feature do
	let!(:user){ FactoryGirl.create :user }
	let!(:project){ FactoryGirl.create :project}
	let!(:ticket){ FactoryGirl.create( :ticket, project: project, user: user) }
	before do
		FactoryGirl.create(:state, name: "Open")
	  define_permission!(user, "view", project)

	  sign_in_as!(user)
	  visit projects_path
	  click_link project.name
	end

	context "Creating an " do
		scenario 'Valid comment' do
		  click_link ticket.title
		  fill_in	'Text', with: 'Added a comment!'
		  click_button 'Create Comment'
		  expect(page).to have_content 'Comment has been created.'
		  within("#comments") do 
			  expect(page).to have_content 'Added a comment!'
		  end
		end
		scenario 'invalid comment' do
		  click_link ticket.title
		  click_button 'Create Comment'
		  expect(page).to have_content "Comment has not been created."
		  expect(page).to have_content("Text can't be blank")
		end
		
	end

	scenario 'Changing a tickets state' do 
		define_permission!(user, "change states", project)
		click_link ticket.title
		fill_in 'Text', with: 'This is a real issue'
		select 'Open', from: 'State'
		click_button 'Create Comment'
		expect(page).to have_content 'Comment has been created.'
		within("#ticket .state") do 
			expect(page).to have_content 'Open'
		end
		within("#comments") do
			expect(page).to have_content "Open"
		end
	end

	scenario 'A user without permission cannot change the state' do
	  click_link ticket.title
	  expect { find("#comment_state_id") }.to raise_error(Capybara::ElementNotFound)
	end

end
