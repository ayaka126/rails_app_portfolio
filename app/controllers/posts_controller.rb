class PostsController < ApplicationController
  before_action :set_facility
  before_action :set_user

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @post_comments = @post.comments 

  end

  def new
    @post = Post.new
  end

  def create
    @post = @user.posts.build(post_params)
    @post.facility = @facility
    if @post.save
      redirect_to @facility, notice: "投稿が作成されました"
    else
      render :new,alert: "投稿できませんでした", status: :unprocessable_entity
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :content)
  end

  def set_facility
    @facility = Facility.find(params[:facility_id])
  end

  def set_user
    @user = User.find(session[:user_id])
  end
end