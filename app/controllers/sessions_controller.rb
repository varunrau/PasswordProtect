class SessionsController < ApplicationController
  before_filter :except => [:create, :destroy]

  def new
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to logins_url, :notice => 'Logged in!'
      session[:password] = params[:password]
    else
      flash.now.alert = 'Invalid email or password'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    session[:revealed] = nil
    redirect_to root_url, :notice => 'Logged out!'
  end
end
