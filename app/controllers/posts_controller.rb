class PostsController < ApplicationController
  before_action :set_facility
  before_action :set_user

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
