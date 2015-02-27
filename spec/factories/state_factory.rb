# == Schema Information
#
# Table name: states
#
#  id         :integer          not null, primary key
#  name       :string
#  color      :string
#  background :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  default    :boolean          default("f")
#

FactoryGirl.define do
	factory :state do 
		name "state"
	end
end
