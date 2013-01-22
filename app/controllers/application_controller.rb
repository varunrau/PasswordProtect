class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  before_filter :force_ssl
  # before_filter :check_if_valid
  # after_filter :update_time

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def force_ssl
    if !request.ssl?
      redirect_to :protocol => 'https'
    end
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
