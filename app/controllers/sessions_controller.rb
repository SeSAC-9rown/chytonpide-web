class SessionsController < ApplicationController
	def new; end

	def create
		auth = request.env["omniauth.auth"]
		user = User.find_by(provider: auth.provider, uid: auth.uid)

		if user
			session[:user_id] = user.id
			redirect_to root_path
		else
			session[:omniauth_provider] = auth.provider
			session[:omniauth_uid] = auth.uid
			session[:omniauth_email] = auth.info.email
			session[:omniauth_avatar] = auth.info.image
			redirect_to new_profile_path
		end
	end

	def destroy
		reset_session
		redirect_to root_path
	end
end