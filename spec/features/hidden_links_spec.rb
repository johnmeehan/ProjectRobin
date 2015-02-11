require 'rails_helper'

RSpec.feature 'HiddenLinks', type: :feature do
  # ensure the right links are shown to the right people
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin_user) }
  let(:project) { FactoryGirl.create(:project) }
  let(:ticket) { FactoryGirl.create(:ticket, project: project, user: user) }

  context 'anonymous users' do
    scenario 'cannot see the new project link' do
      visit '/'
      assert_no_link_for 'New Project'
    end

    scenario 'Cannot see the Edit Project link' do
      visit project_path(project)
      assert_no_link_for 'Edit Project'
    end

    scenario 'Cannot see the Delete Project link' do
      visit project_path project
      assert_no_link_for 'Delete Project'
    end
  end

  context 'regular user' do
    before { sign_in_as!(user) }
    scenario 'cannot see the New Project Link' do
      visit '/'
      assert_no_link_for 'New Project'
    end

    scenario 'Cannot see the Edit Project link' do
      visit project_path(project)
      assert_no_link_for 'Edit Project'
    end

    scenario 'Cannot see the Delete Project link' do
      visit project_path project
      assert_no_link_for 'Delete Project'
    end

    scenario 'New ticket link is shown to a user with permission' do
      define_permission!(user, 'view', project)
      define_permission!(user, 'create tickets', project)
      visit project_path(project)
      assert_link_for 'New Ticket'
    end

    scenario 'New ticket link is hidden from a user without permission' do
      define_permission!(user, 'view', project)
      visit project_path project
      assert_no_link_for 'New Ticket'
    end

    scenario 'Edit ticket link is shown to a user with permission' do
      ticket
      define_permission!(user, 'view', project)
      define_permission!(user, 'edit tickets', project)
      visit project_path project
      click_link ticket.title
      assert_link_for 'Edit Ticket'
    end

    scenario 'Edit ticket link is hidded from a user without permission' do
      ticket
      define_permission!(user, 'view', project)
      visit project_path project
      click_link ticket.title
      assert_no_link_for 'Edit Ticket'
    end

    scenario 'Delete ticket link is shown to a usere with permission' do
      ticket
      define_permission!(user, 'view', project)
      define_permission!(user, 'delete tickets', project)
      visit project_path project
      click_link ticket.title
      assert_link_for 'Delete Ticket'
    end

    scenario 'Delete ticket link is not show without permission' do
      ticket
      define_permission!(user, 'view', project)
      visit project_path project
      click_link ticket.title
      assert_no_link_for 'Delete Ticket'
    end
  end

  context 'Admin users' do
    before { sign_in_as!(admin) }
    scenario 'can see the New Project link' do
      visit '/'
      assert_link_for 'New Project'
    end

    scenario 'Can see the Edit Project link' do
      visit project_path(project)
      assert_link_for 'Edit Project'
    end

    scenario 'Can see the Delete Project link' do
      visit project_path project
      assert_link_for 'Delete Project'
    end

    scenario 'New ticket link is shown to admins' do
      visit project_path project
      assert_link_for 'New Ticket'
    end

    scenario 'Edit ticket link is shown to admins' do
      ticket
      visit project_path project
      click_link ticket.title
      assert_link_for 'Edit Ticket'
    end
    scenario 'Deleter link is shown to admins' do
      ticket
      visit project_path project
      click_link ticket.title
      assert_link_for 'Delete Ticket'
    end
  end
end
