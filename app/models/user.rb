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

class User < ActiveRecord::Base
  has_many :permissions
  validates :email, presence: true
  has_secure_password
  def to_s
    "#{email} (#{admin? ? "Admin" : "User"})"
  end
end
