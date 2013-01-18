class UsersController < ApplicationController

  def new
    if current_user
      redirect_to logins_path
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

  def logins
    if current_user
      @id = current_user.id
      @logins = Login.find_all_by_user_id(current_user.id)
      @login = Login.new
      @login.user_id = current_user.id
    else
      redirect_to root_url, :notice => "Need to login"
    end
  end

  def addlogin
    @login = Login.new(params[:login])
    @login.user_id = current_user.id
    if @login.save
      redirect_to root_url, :notice => "Added new login"
    else
      redirect_to root_url, :notice => "Couldn't add login"
    end
  end

  def search
    @test = 'facebook'
    redirect_to root_url, :notice => "Search"
  end

  def deletelogin
    @login = Login.find(params[:id])
    @login.destroy

    respond_to do |format|
      format.html { redirect_to root_url :notice => "Login removed" }
      format.json { head :no_content }
    end
  end

end
