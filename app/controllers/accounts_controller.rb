class AccountsController < ApplicationController

  def edit
    user = User.find_by(email: params[:email])
    if user && user.inactive? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      redirect_to edit_user_path(user), notice: 'Account activated,
                                                 please set your timezone'
    else
      redirect_to root_url, alert: 'Invalid activation link.'
    end
  end
end
