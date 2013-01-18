class UsersController < ApplicationController

  def new
    if current_user
      render :text => "Logged In"
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_url, :notice => "Signed Up!"
    else
      render "new"
    end
  end
end
