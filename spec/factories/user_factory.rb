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
#  admin           :boolean          default(FALSE)
#

FactoryGirl.define do
  sequence(:email) { |n| "user#{n}@example.com" }
  factory :user do
    name 'John'
    email { generate(:email) }
    password 'password'
    password_confirmation 'password'

    factory :admin_user do
      admin true
    end
  end
end
