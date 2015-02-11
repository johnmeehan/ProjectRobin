require 'rails_helper'

RSpec.feature "Seeds", type: :feature do
	scenario 'The basics' do
	  load Rails.root + "db/seeds.rb"
	  user = User.where(email: "admin@example.com").first!
	  project = Project.where(name: "Ticketee Beta").first!
	end
end
