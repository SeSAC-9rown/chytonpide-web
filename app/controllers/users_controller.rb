class UsersController < ApplicationController
	def new
		redirect_to root_path and return unless omniauth_present?
		
		@user = User.new(
			email: session[:omniauth_email],
			social_avatar_url: session[:omniauth_avatar_url]
		)
	end

	def create
		redirect_to root_path and return unless omniauth_present?
		
		user = User.new(
			email: session[:omniauth_email],
			provider: session[:omniauth_provider],
			uid: session[:omniauth_uid],
			name: user_params[:name],
			avatar_url: user_params[:avatar_url],
			social_avatar_url: session[:omniauth_avatar_url]
		)
		
		if user.save
			session[:user_id] = user.id
			clear_omniauth_session
			redirect_to root_path
		else
			@user = user
			render :new
		end
	end
	
	private
	
	def user_params
		params.require(:user).permit(:name, :avatar_url)
	end
	
	def omniauth_present?
		session[:omniauth_provider].present? && session[:omniauth_uid].present?
	end

	def clear_omniauth_session
		session.delete(:omniauth_provider)
		session.delete(:omniauth_uid)
		session.delete(:omniauth_email)
		session.delete(:omniauth_avatar_url)
	end
end