class AccountsController < ApplicationController

  def edit
    user = User.find_by(email: params[:email])
    if user && user.inactive? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:notice] = 'Account Activated!'
      redirect_to user  # Later, allow them to go to settings.
    else
      redirect_to root_url, alert: 'Invalid activation link.'
    end
  end
end
