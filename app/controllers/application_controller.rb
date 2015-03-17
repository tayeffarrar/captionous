class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
  	return nil unless session[:session_token]
  	@current_user ||= User.find_by(session_token: session[:session_token])
  end

  private

  def login!(user)
  	return nil unless session[:session_token]
  	@current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logout!
  	current_user.update(session_token: nil)
  	session[:session_token] = make_token
  end

  def make_token
  	return SecureRandom.urlsafe_base64
  end

  def require_current_user
  	redirect_to new_session_url unless current_user
  end
end
