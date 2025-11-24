class ProfilesController < ApplicationController
  def new
      redirect_to root_path and return unless omniauth_present?
      @user = User.new(
        email: session[:omniauth_email],
        avatar_url: session[:omniauth_avatar]
    )
  end

  def create
    redirect_to root_path and return unless omniauth_present?

    user = User.new(
      name: profile_params[:name],
      provider: session[:omniauth_provider],
      uid: session[:omniauth_uid],
      email: session[:omniauth_email],
      avatar_url: session[:omniauth_avatar]
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

  def profile_params
    # user.name 파라미터 가져옴
    params.require(:user).permit(:name)
  end

  def omniauth_present?
    session[:omniauth_provider].present? && session[:omniauth_uid].present?
  end

  def clear_omniauth_session
    session.delete(:omniauth_provider)
    session.delete(:omniauth_uid)
    session.delete(:omniauth_email)
    session.delete(:omniauth_avatar)
  end
end
