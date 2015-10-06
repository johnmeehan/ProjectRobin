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
#  default    :boolean          default(FALSE)
#

class State < ActiveRecord::Base
  # TODO: Will need to validates its uniqueness within the scope of its owning project
  validates_uniqueness_of :name
  validates_length_of :background, maximum: 7
  validates_length_of :color, maximum: 7

  def to_s
    name
  end

  def default!
    # current_default_state = State.find_by(default: true)
    # self.default = true
    # self.save!

    # if current_default_state
    # 	current_default_state.default = false
    # 	current_default_state.save!

    # end

    ## v2
    # State.update_all(default: false)

    ## v3
    State.find_by(default: true).try(:update!, default: false)
    update!(default: true)
  end
end
