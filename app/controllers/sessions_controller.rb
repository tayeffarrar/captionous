class SessionsController < ApplicationController
  before_action :require_current_user, only: :destroy

  def new
  	@user = User.new
  end

  def create
  	@user = User.find_by(username: session_params[:username])

  	if @user && @user.authenticate(session_params[:password])
  		login!(@user)

  		redirect_to pictures_show_url
  	else
  		redirect_to new_session_url, alert: "Username and/or password incorrect" #add error message?
  	end
  end

  def destroy
  	logout!

  	redirect_to new_session_url
  end

  private

  def session_params
  	@session_params ||= params.require(:session).permit(:username, :password)
  end
end