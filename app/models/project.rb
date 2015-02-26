# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Project < ActiveRecord::Base
  validates :name, presence: true
  has_many :tickets, dependent: :delete_all
  has_many :permissions, as: :thing

  scope :viewable_by, ->(user) {
  	joins(:permissions).where(permissions: { action: 'view', user_id: user.id })
  }

  scope :for, ->(user) do
    user.admin? ? Project.all : Project.viewable_by(user)
  end
end
