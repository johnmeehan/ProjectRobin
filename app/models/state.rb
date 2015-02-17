class State < ActiveRecord::Base

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
