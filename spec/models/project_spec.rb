require 'rails_helper'

RSpec.describe Project, type: :model do
  it { should respond_to :name }
  it { should respond_to :description }
  it { should belong_to :user }
end
