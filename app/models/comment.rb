# == Schema Information
#
# Table name: comments
#
#  id                :integer          not null, primary key
#  text              :text
#  ticket_id         :integer
#  user_id           :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  state_id          :integer
#  previous_state_id :integer
#

class Comment < ActiveRecord::Base
	belongs_to :ticket
	belongs_to :user
	belongs_to :state
	belongs_to :previous_state, class_name: "State"

	validates_presence_of :text

	before_create :set_previous_state
	after_create :set_ticket_state

	delegate :project, to: :ticket # ticket.project

	private
		def set_previous_state
			self.previous_state = ticket.state 
		end
	
		def set_ticket_state
			self.ticket.state = self.state 
			self.ticket.save!
		end
end
