class Comment < ActiveRecord::Base
	belongs_to :ticket
	belongs_to :user
	belongs_to :state
	validates_presence_of :text

	after_create :set_ticket_state

	delegate :project, to: :ticket # ticket.project

	private
		def set_ticket_state
			self.ticket.state = self.state 
			self.ticket.save!
		end

end
