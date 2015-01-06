class AccountsController < ApplicationController

  def edit
    user = User.find_by(email: params[:email])
    if user && !user.active? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:notice] = 'Account Activated!'
      redirect_to user  # Later, allow them to go to settings.
    else
      flash[:alert] = 'Invalid activation link.'
      redirect_to root_url
    end
  end
end
