class TopicsController < ApplicationController
  before_action :logged_in_user?, only: [:new, :create, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def index
    @topics = Topic.level(get_user_level).includes(:comments)
                   .paginate(page: params[:page], per_page: 15)
                   .order('topics.sticky DESC', 'comments.created_at DESC')
  end

  def show
    @topic = Topic.find(params[:id])
    if Topic.levels[@topic.level] > get_user_level
      redirect_to topics_path, alert: 'Unauthorized to view.'
    else
      @comments = @topic.comments.paginate(page: params[:page], per_page: 15)
                        .order('created_at ASC')
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
      redirect_to topic_path(@topic), notice: 'Topic successfully updated.'
    else
      render 'edit'
    end
  end

  private
    def topic_params
      if current_user.admin?
        params.require(:topic).permit(:title, :level, :sticky,
                                      comments_attributes: [:content])
      elsif User.levels[current_user.level] > 0
        params.require(:topic).permit(:title, :level,
                                      comments_attributes: [:content])
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
