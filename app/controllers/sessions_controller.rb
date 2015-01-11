class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(name: params[:session][:name].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.active?
        log_in user
        user.update(last_login: Time.now)
        redirect_back_or(params[:url].blank? ? user : params[:url])
      else
        message = 'Account not activated. '
        message += 'Check your email for the activation link.'
        redirect_to root_url, alert: message
      end
    else
      flash.now[:alert] = 'Invalid username/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url, notice: 'You have logged out.'
  end
end
