class Admin::StatesController < ApplicationController
	layout 'admin', only: [:index]
	def index
		@states = State.all
	end
	def new
		@state = State.new
	end

	def edit
		@state = get_state
	end

	def create
		@state = State.new(state_params)
		if @state.save
			flash[:notice] = "State has been created."
			redirect_to admin_states_path
		else
			flash[:alert] = "State has not been created."
			render :new
		end
	end

	def update	
		#FIXME: changing state details not appearing in the CSS
		@state = get_state
		if @state.update(state_params)
      flash[:notice] = "State has been updated."
      redirect_to admin_states_path
    else
      flash[:alert] = "State has not been updated."
      render action: "edit"
    end
	end

	def make_default
		@state = get_state
		@state.default!
		flash[:notice] = "#{@state.name} is now the default state."
		redirect_to admin_states_path
	end

	private
		def state_params
			params.require(:state).permit(:name, :background, :color)
		end

		def get_state
			State.find(params[:id])
		end
end
