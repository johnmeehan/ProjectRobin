require 'rails_helper'

RSpec.describe State, type: :model do
	it { should validate_uniqueness_of :name } 
	it { should validate_length_of(:background).is_at_most 7 }
	it { should validate_length_of(:color).is_at_most 7 }
end