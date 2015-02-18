require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
	let(:user) { FactoryGirl.create :user }
	let(:permitted_user) { FactoryGirl.create(:user, name: 'Meehan') }
	let(:admin) { FactoryGirl.create(:admin_user) }
	let(:project) { FactoryGirl.create( :project, name: "Ticketee") }
	let(:ticket) do
		project.tickets.create(title: "State transitions", description: "Can't be hacked.", user: user ) 
	end
	let(:state) { State.create!(name: "New") }


	context "a user without permission to set state" do
		before do
		  sign_in(user)
		end

		it "cant change a state by passing through state_id" do
			post :create, { 
				:comment => { :text => "Cant touch this!", :state_id => state.id },
				:ticket_id => ticket.id  
			}
			ticket.reload
			expect(ticket.state).to_not be state
		end
	end



	context 'a user with permission to change state' do 
		before do
			define_permission!(permitted_user, "view", project)
			define_permission!(permitted_user, "change states", project)
			define_permission!(permitted_user, "create tickets", project)
			# permitted_user.permissions.create!(action: "change states", thing: project)
			# permitted_user.permissions.create!(action: "view", thing: project)
			# permitted_user.permissions.create!(action: "create tickets", thing: project)
		  sign_in permitted_user
		end
		it 'can change states' do 
		  post :create, {
				comment: { text: "Call yourself a user?", state_id: state.id }, 
				ticket_id: ticket.id 
			}
			ticket.reload

			expect(ticket.state.name).to eq state.name
		end
	end
	context 'a admin user with permission to change state' do 
		before do
		  sign_in admin 
		end
		it 'can change states' do 
		  post :create, { 
				comment: { text: "Administer this knunkle head!", state_id: state.id }, 
				ticket_id: ticket.id 
			}
			ticket.reload

			expect(ticket.state.name).to eq "New"
		end
	end
end
