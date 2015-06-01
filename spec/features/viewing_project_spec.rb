require 'rails_helper'

feature 'Viewing projects' do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:project) { FactoryGirl.create(:project) }
  let!(:hidden) { FactoryGirl.create(:project, name: 'Hidden') }
  let!(:admin) { FactoryGirl.create(:admin_user) }
  let!(:admin_project) { FactoryGirl.create(:project, name: 'Admins project', user_id: admin.id) }
  context 'User' do
    before do
      sign_in_as!(user)
      define_permission!(user, :view, project)
    end

    scenario 'Listing all projects' do
      visit projects_path
      expect(page).to_not have_content('Hidden')
      expect(page).to_not have_content admin_project.name
      click_link project.name
      expect(page.current_url).to eql(project_url(project))
    end
  end

  context 'Admin' do
    before do
      sign_in_as!(admin)
    end
    scenario 'Lists projects the user has created'  do
      visit projects_path
      expect(page).to have_content admin_project.name
      expect(page).to_not have_content hidden.name
    end
  end
end
