# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  admin           :boolean          default("f")
#

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'email' do 
    it { should validate_uniqueness_of :email }
    it { should have_db_index :email }
    it { should have_many :projects }
  
    it "must have correct email format" do 
      expect(User.new(email: " 23~4.com")).to have(1).errors_on(:email)
    end
  end

  describe 'requires an email' do
    it "requires and email" do
      u = User.new(name: "steve", password: "hunter2", password_confirmation: "hunter2")
      u.save
      expect(u).to_not be_valid
    end
  end
  describe 'password' do
    it "needs a password and confirmation to save" do
      u = User.new(name: "steve", email: "steve@example.com")
      u.save
      expect(u).to_not be_valid

      u.password = "password"
      u.password_confirmation = ""
      u.save
      expect(u).to_not be_valid

      u.password_confirmation = "password"
      u.save
      expect(u).to be_valid
    end

    it "needs password and confirmation to match" do
      u = User.create(name: "steve",  email: "steve@example.com",password: "hunter2", password_confirmation: "hunter")
      expect(u).to_not be_valid
    end
  end

  describe 'authentication' do
    let(:user) { User.create(name: "steve", email: "steve@example.com", password: "hunter2", password_confirmation: "hunter2") }

    it "authenticeates with a correct password" do
      expect(user.authenticate("hunter2")).to be
    end
    it "does not authenticate with an incorrect password" do
      expect(user.authenticate("hunter1")).to_not be
    end
  end
end
