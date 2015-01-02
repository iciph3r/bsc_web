class LogsController < ApplicationController
  before_action :logged_in_user?, only: [:new, :create, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def index
  end

  def show
  end

  def new
    @log = current_user.logs.build
  end

  def create
  end

  def edit
  end

  def update
  end

  private
    def log_params
      params.require(:log).permit(:title, :description, :bsc)
    end

end
