class AdminController < ApplicationController
  before_action :authorized?
  before_action :site_admin?, only: :delete

  private
    def authorized?
      unless logged_in_user?
        unless current_user.admin?
          flash[:alert] = 'Only administrators may access this resource.'
          redirect_to root_url
        end
      end
    end

    def site_admin?
      # Check current_user.site_admin?
    end
end
