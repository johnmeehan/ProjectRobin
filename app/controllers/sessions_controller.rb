class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.where(email: params[:signin][:email]).first

    if user && user.authenticate(params[:signin][:password])
      session[:user_id] = user.id
      flash[:notice] = 'Signed in successfully.'
      redirect_to projects_path
    else
      flash[:error] = 'Sorry.'
      render :new
    end
  end

  def destroy
    # to signout set the session id to nil
    session[:user_id] = nil
    flash[:notice] = 'Signed out successfully.'
    # FIXME: root url is currently projects index which is protected.
    redirect_to root_url
  end
end
