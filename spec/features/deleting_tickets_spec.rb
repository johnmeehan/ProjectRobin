require 'rails_helper'

RSpec.feature "DeletingTickets", type: :feature do
  let!(:project){ FactoryGirl.create(:project) }
  let!(:user)   { FactoryGirl.create(:user) }
  let!(:ticket) { FactoryGirl.create(:ticket, project: project, user: user) }

  before do
    sign_in_as!(user)
    visit root_path
    click_link project.name
    click_link ticket.title
  end

  scenario "Deleting a ticket" do
    click_link "Delete Ticket"
    expect(page).to have_content("Ticket has been deleted.")
    expect(page.current_url).to eq(project_url(project))
  end
end
