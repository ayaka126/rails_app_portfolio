class PostsController < ApplicationController
  before_action :set_facility
  before_action :set_user
  before_action :set_post, only: [:edit, :update]

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    ActiveStorage::Current.url_options = Rails.application.config.action_mailer.default_url_options
    @comment = Comment.new
    @comments = @post.comments.includes(:user).order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = @user.posts.build(post_params)
    @post.facility = @facility
    if @post.save
      redirect_to facility_posts_path, notice: "投稿が作成されました"
    else
      render :new,alert: "投稿できませんでした", status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to facility_post_path(@facility, @post), notice: "投稿内容を変更しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to facility_posts_path, notice: "投稿が削除されました"
    else
      redirect_to facility_post_path(@facility, @post), alert: "投稿の削除に失敗しました"
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

  def set_post
    @post = Post.find(params[:id])
  end
end
