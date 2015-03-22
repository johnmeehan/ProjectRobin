class UsersController < ApplicationController
 
  def new
    new_user
  end

  def create
    new_user(user_params)
    @user.toggle :admin  #A signed up user will be a paying user therefore default
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "You have signed up successfully."
      redirect_to projects_path
    else
      render :new
    end
  end

  def show
    set_user
  end

  def edit
    set_user
  end

  def update
    set_user
    if @user.update(user_params)
      flash[:notice] = "Profile has been updated."
      redirect_to [@user]
    else
      flash[:alert] = "Profile has not been updated."
      render action: "edit"
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation )
    end

    def new_user(values = {})  
      @user = User.new(values)
    end

    def set_user  
      @user = User.find(params[:id])
    end

end
