# == Schema Information
#
# Table name: tickets
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  project_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  state_id    :integer
#

FactoryGirl.define do
  factory :ticket do
    title "Example ticket"
    description "An example ticket, nothing more"
  end
end
