class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :mobild_devise?
  before_filter :set_login_password
  # before_filter :prepare_for_mobile
  before_filter :check_if_valid
  # after_filter :update_time

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end


  def mobile_devise?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user.agent =~ /Mobile|webOS/
    end
  end

  def set_login_password
    puts 'the session password is ...'
    print session[:password]
    logins = Login.find_all_by_user_id(session[:user_id])
    logins.each { |login|
      # I'm not sure how kosher this is...
      login.set_session_password(session[:password])
    }
    # We want to keep around this password for as little time as possible
    session[:password] = nil
  end

  def prepare_for_mobile
    session[:mobile_param] = params[:mobile] if params[:mobile]
    request.format = :mobile if mobile_devise?
  end

  def check_if_valid
    time = session[:last_action]
    if time
      if time.since(10).future?()
        puts 'destroy session'
        flash.now.notice = "For security reasons, your session has expired. Please login to access your information."
        destroy
      end
    else
      session[:last_action] = Time.now
    end
  end

  def update_time
    session[:last_action] = Time.now
  end

end
