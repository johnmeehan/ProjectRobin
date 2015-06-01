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

class Ticket < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  belongs_to :state
  has_many :assets
  has_many :comments

  validates :title, presence: true
  validates :description, presence: true, length: { minimum: 10 }

  accepts_nested_attributes_for :assets
end
