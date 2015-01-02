class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:notice] = 'Please check your email for password reset instructions'
      redirect_to root_url
    else
      flash.now[:alert] = 'Email address not found'
      render 'new'
    end
  end

  def edit
  end

  def update
    if both_passwords_blank?
      flash.now[:alert] = "Password can't be blank"
      render 'edit'
    elsif @user.update_attributes(user_params)
      log_in @user
      flash[:notice] = 'Password successfully reset.'
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    # Check passwords are not blank.
    def both_passwords_blank?
      params[:user][:password].blank? &&
      params[:user][:password_confirmation].blank?
    end

    ### Before_filters
    def get_user
      @user = User.find_by(email: params[:email])
    end

    # Confirms user is valid.
    def valid_user
      unless (@user && @user.activated? &&
              @user.authenticated?(:reset, params[:id]))
        redirect_to root_url
      end
    end

    def check_expiration
      if @user.password_reset_expired?
        flash[:alert] = 'Password reset has expired.'
        redirect_to new_password_reset_url
      end
    end
end
