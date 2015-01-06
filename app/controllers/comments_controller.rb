class CommentsController < ApplicationController
  before_action :logged_in_user?, only: [:create, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def create
    @context = context
    @comment = @context.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to context_url(@context)
    else
      render 'new'
    end
  end

  def edit
    @context = context
    @comment = @context.comments.find(params[:id])
  end

  def update
    @context = context
    @comment = @context.comments.find(params[:id])
    @comment.update_attributes(comment_params)
    if @comment.save
      redirect_to context_url(@context), notice: 'Update success.'
      @context.decrement_view
    else
      render 'edit'
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end

    # Find the commentable_type (Topic or Log), fix this using object.
    def context
      if params[:topic_id]
        Topic.find(params[:topic_id])
      elsif params[:log_id]
        Log.find(params[:log_id])
      end
    end

    # Redirect based on context.
    def context_url(context)
      if Topic === context
        topic_path(context)
      elsif Log === context
        log_path(context)
      end
    end

    # Ensure only the comment owner may edit their comment.
    def correct_user
      comment = Comment.find(params[:id])
      message = 'You may only edit your own comments.'
      unless current_user?(comment.user)
        redirect_to(root_url, alert: message)
      end
    end
end
