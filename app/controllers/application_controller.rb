class ApplicationController < ActionController::Base
	allow_browser versions: :modern
	stale_when_importmap_changes
	helper_method :current_user, :user_signed_in?
	
	private
	
	def current_user
		return @current_user if defined?(@current_user)
		@current_user = User.find_by(id: session[:user_id])
	end
	
	def user_signed_in?
		current_user.present?
	end

	def require_login
		redirect_to login_path unless user_signed_in?
	end
end