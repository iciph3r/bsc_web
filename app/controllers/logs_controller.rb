class LogsController < ApplicationController
  before_action :logged_in_user?, only: [:new, :create, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def index
    @logs = Log.all
  end

  def show
    @log = Log.find(params[:id])
    @log_text = File.read(Rails.root.join('public', 'logs', @log.path))
  end

  def new
    @log = current_user.logs.build
  end

  def create
    @log = current_user.logs.build(log_params)
    if params[:log][:log_file]
      @log.path = "#{current_user.name}_#{Time.now.strftime('%F_%T')}.log"
    else
      @log.errors.add(:base, 'Must select a log to upload.')
    end
    if @log.save
      File.open(Rails.root.join('public', 'logs', @log.path), 'wb') do |file|
        file.write(params[:log][:log_file].read)
      end
      redirect_to logs_path, notice: 'Log successfully uploaded.'
    else
      render 'new'
    end
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
