class Admin::UsersController < Admin::BaseController
  layout 'admin', only: [:index, :show]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    get_project_users
  end

  def new
    new_user
  end

  def create
    create_new_user
    if @user.save
      flash[:notice] = 'User has been created.'
      redirect_to admin_users_path
    else
      flash.now[:alert] = 'User has not been created.'
      render action: 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    remove_password_from_params if params[:user][:password].blank?
    if @user.update(user_params)
      flash[:notice] = 'User has been updated.'
      redirect_to admin_users_path
    else
      flash[:alert] = 'User has not been update.'
      render action: 'edit'
    end
  end

  def destroy
    if @user == current_user
      flash[:alert] = 'You cannot delete yourself!'
    else
      @user.destroy
      flash[:notice] = 'User has been deleted.'
    end
    redirect_to admin_users_path
  end

  private

  def user_params
    params.require(:user).permit(:name,
                                 :email,
                                 :password,
                                 :password_confirmation,
                                 :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def get_project_users
    @users = User.order(:email)
  end

  def create_new_user
    params = user_params.dup
    params[:password_confirmation] = params[:password]
    new_user(params)
  end

  def new_user(params = {})
    @user = User.new(params)
  end

  def remove_password_from_params
    params[:user].delete(:password)
    params[:user].delete(:password_confirmation)
  end
end
