class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  around_action :set_time_zone
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

    def get_user_level
      current_user ? User.levels[current_user.level] : 0
    end

    def set_time_zone(&block)
      time_zone = current_user.try(:timezone) || 'UTC'
      Time.use_zone(time_zone, &block)
    end
end
