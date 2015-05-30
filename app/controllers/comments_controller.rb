class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @stryke = Stryke.find(params[:stryke_id])
    @comment.stryke_id = @stryke.id
    @comment.user_id = current_user.id
    @comment.spark_count = 0
    if @comment.save
      render partial: 'welcome/comment', locals: {comment: @comment}
    else
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :user_id, :stryke_id)
  end

end
