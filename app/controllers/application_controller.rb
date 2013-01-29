class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  # before_filter :prepare_for_mobile
  # before_filter :check_if_valid
  # after_filter :update_time

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :mobile_device?

  def mobile_devise?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user.agent =~ /Mobile|webOS/
    end
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
