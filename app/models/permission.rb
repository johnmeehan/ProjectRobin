# == Schema Information
#
# Table name: permissions
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  thing_id   :integer
#  thing_type :string
#  action     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Permission < ActiveRecord::Base
  belongs_to :user
  belongs_to :thing, polymorphic: true
end
