class UsersController < ApplicationController

  def new
    if current_user
      redirect_to root_url
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to logins_path, :notice => "Signed Up!"
    else
      render "new"
    end
  end

  def logins
    unless session[:revealed]
      session[:revealed] = Array.new
    end

    @revealed_logins = session[:revealed]

    if current_user
      @logins = Login.find_all_by_user_id(current_user.id, :order => sort_column + ' ' + sort_direction)

      # In case the user decides to create a new login
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
      redirect_to logins_path, :notice => "Added new login"
    else
      redirect_to logins_path, :notice => "Couldn't add login"
    end
  end

  def search
    if current_user
      @logins = Login.where("user_id = ? AND org = ? OR user_name = ?", current_user.id, params[:query], params[:query])
      @login = Login.new
      @login.user_id = current_user.id
    else
      redirect_to root_url, :notice => 'Please login'
    end
  end

  def deletelogin
    @login = Login.find(params[:id])
    @login.destroy

    respond_to do |format|
      format.html { redirect_to root_url :notice => "Login removed" }
      format.json { head :no_content }
    end
  end

  def reveal
    login = Login.find(params[:id])
    login.to_string()
    session[:revealed] << login
    @revealed_logins = session[:revealed]
    respond_to do |format|
      format.html { redirect_to logins_path }
      format.json { head :no_content }
    end
  end

  def sort_column
    Login.column_names.include?(params[:sort]) ? params[:sort] : 'org'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end

end
