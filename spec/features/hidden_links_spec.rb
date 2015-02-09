require 'rails_helper'

RSpec.feature "HiddenLinks", type: :feature do
  # ensure the right links are shown to the right people
  let(:user) { FactoryGirl.create(:user) }
  let(:admin){ FactoryGirl.create(:admin_user) }
  let(:project){ FactoryGirl.create(:project) }

  context "anonymous users" do
    scenario "cannot see the new project link" do
      visit '/'
      assert_no_link_for "New Project"
    end

    scenario "Cannot see the Edit Project link" do
      visit project_path(project)
      assert_no_link_for "Edit Project"
    end

    scenario "Cannot see the Delete Project link" do
      visit project_path project
      assert_no_link_for "Delete Project"
    end
  end

  context "regualar user" do
    before { sign_in_as!(user) }
    scenario "cannot see the New Project Link" do
      visit '/'
      assert_no_link_for "New Project"
    end

    scenario "Cannot see the Edit Project link" do
      visit project_path(project)
      assert_no_link_for "Edit Project"
    end

    scenario "Cannot see the Delete Project link" do
      visit project_path project
      assert_no_link_for "Delete Project"
    end
  end

  context "Admin users" do
    before { sign_in_as!(admin) }
    scenario "can see the New Project link" do
      visit '/'
      assert_link_for "New Project"
    end

    scenario "Cannot see the Edit Project link" do
      visit project_path(project)
      assert_link_for "Edit Project"
    end

    scenario "Cannot see the Delete Project link" do
      visit project_path project
      assert_link_for "Delete Project"
    end
  end
end
