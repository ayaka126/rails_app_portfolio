class CommentsController < ApplicationController
  before_action :set_post

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.post_id = @post.id
    if @comment.save
      redirect_to facility_post_path(@post.facility, @post), notice: "コメントが投稿されました"
    else
      redirect_to facility_post_path(@post.facility, @post), alert: "コメントの投稿に失敗しました", status: :unprocessable_entity
    end
  end

  def destroy
    Comment.find_by(id: params[:id],post_id: params[:post_id]).destroy
    redirect_to facility_post_path(@post.facility, @post), notice: "コメントを削除しました"
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
