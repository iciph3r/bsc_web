class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private
    def logged_in_user?
      unless logged_in?
        store_location
        flash[:alert] = 'Please log in.'
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url, alert: 'Nope :(') unless current_user?(@user)
    end
end
