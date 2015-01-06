class TopicsController < ApplicationController
  before_action :logged_in_user?, only: [:new, :create, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def index
    if !current_user || !current_user.bsc?
      @topics = Topic.not_bsc.includes(:comments)
                     .paginate(page: params[:page])
                     .order('comments.created_at DESC')
    elsif current_user.bsc?
    @topics = Topic.includes(:comments).paginate(page: params[:page])
                   .order('comments.created_at DESC')
    end
  end

  def show
    @topic = Topic.find(params[:id])
    if @topic.bsc? && !current_user.bsc?
      redirect_to topics_path, alert: 'You can not view BSC logs.'
      return
    else
      @comments = @topic.comments.paginate(page: params[:page])
      @topic.increment_view
    end
  end

  def new
    @topic = current_user.topics.build
    @topic.comments.build
  end

  def create
    @topic = current_user.topics.build(topic_params)
    @topic.comments.first.user_id = current_user.id
    if @topic.save
      redirect_to topic_path(@topic)
    else
      render 'new'
    end
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])
    if @topic.update_attributes(topic_params)
      @topic.decrement_view  # Do not count update as a view.
      flash[:notice] = 'Topic successfully updated.'
      redirect_to topic_path(@topic)
    else
      render 'edit'
    end
  end

  private
    def topic_params
      if current_user.admin?
        params.require(:topic).permit(:title, :bsc, :sticky, comments_attributes: [:content])
      elsif current_user.bsc?
        params.require(:topic).permit(:title, :bsc, comments_attributes: [:content])
      else
        params.require(:topic).permit(:title, comments_attributes: [:content])
      end
    end

    def correct_user
      topic = Topic.find(params[:id])
      m = 'You may only edit your own topics.'
      redirect_to(topic_path(topic), alert: m) unless current_user?(topic.user)
    end
end
