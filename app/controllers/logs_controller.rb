class LogsController < ApplicationController
  before_action :logged_in_user?, only: [:new, :create, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def index
    @logs = Log.level(get_user_level)
               .paginate(page: params[:page], per_page: 15)
               .order('logs.created_at DESC')
  end

  def show
    @log = Log.find(params[:id])
    if Log.levels[@log.level] > get_user_level
      redirect_to logs_path, alert: 'Unauthorized to view.'
    else
      @log_text = Log.read_log(@log)
      @comments = @log.comments.paginate(page: params[:page], per_page: 15)
                               .order('created_at DESC')
      @log.increment_view
    end
  end

  def new
    @log = current_user.logs.build
  end

  def create
    @log = current_user.logs.build(log_params)
    if params[:log][:log_file]
      @log.path = "#{current_user.name}_#{Time.now.utc.strftime('%FT%TZ')}.log"
    end
    if @log.save
      Log.save_log(params[:log][:log_file], @log)
      redirect_to log_path(@log), notice: 'Log successfully uploaded.'
    else
      render 'new'
    end
  end

  def edit
    @log = Log.find(params[:id])
  end

  def update
    @log = Log.find(params[:id])
    if @log.update_attributes(log_params)
      @log.decrement_view
      redirect_to log_path(@log), notice: 'Update successful.'
    else
      render 'edit'
    end
  end

  private
    def log_params
      params.require(:log).permit(:title, :description, :level)
    end

    def correct_user
      log = Log.find(params[:id])
      m = 'You may only edit your own logs.'
      redirect_to(log_path(log), alert: m) unless current_user?(log.user)
    end
end
