require 'rails_helper'

RSpec.feature 'EditingProjects', type: :feature do
  before do
    @admin = FactoryGirl.create(:admin_user)
    sign_in_as!(@admin)
    FactoryGirl.create(:project, name: 'TextMate 2', user_id: @admin.id)
    visit projects_path
    click_link 'TextMate 2'
    click_link 'Edit Project'
  end

  scenario 'Updating a project' do
    fill_in 'Name', with: 'TextMate 2 beta'
    click_button 'Update Project'
    expect(page).to have_content('Project has been updated.')
  end

  scenario 'Updateing a project with invalid attributes' do
    fill_in 'Name', with: ''
    click_button 'Update Project'
    expect(page).to have_content('Project has not been updated.')
  end
end
