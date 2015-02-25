require 'rails_helper'

RSpec.feature "Seeds", type: :feature do
	# these 2 ets are used to get it to test the States part
	let!(:user) { FactoryGirl.create(:admin_user) }
  let!(:project) { FactoryGirl.create(:project) }
	scenario 'The basics' do
	  load Rails.root + "db/seeds.rb"
	  # user = User.where(email: "admin@example.com").first!
	  # project = Project.where(name: "Ticketee Beta").first!
	  sign_in_as!(user)
	  # click_link "Ticketee Beta"
	  click_link project.name
	  click_link 'New Ticket'
	  fill_in 'Title', with: "Comments with state"
	  fill_in 'Description', with: 'Comments always have a state.'
	  click_button 'Create Ticket'

	  within("#comment_state_id") do 
	  	expect(page).to have_content 'New'
	  	expect(page).to have_content 'Open'
	  	expect(page).to have_content 'Closed'
	  end
	end
end
