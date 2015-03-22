require 'rails_helper'

RSpec.feature "DeletingProjects", type: :feature do
  before do
    @admin = FactoryGirl.create(:admin_user)
    sign_in_as!(@admin)
  end
  scenario "Deleting a project" do
    FactoryGirl.create(:project, name: "TextMate 2", user_id: @admin.id )

    visit projects_path
    click_link "TextMate 2"
    click_link "Delete Project"
    expect(page).to have_content("Project has been destroyed.")
    visit projects_path
    expect(page).to have_no_content("TextMate 2")
  end
end
