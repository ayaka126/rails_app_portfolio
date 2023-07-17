class UsersController < ApplicationController
  before_action :already_login?, only: [:new, :create]
  before_action :login?, only: :show

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path, notice: "新規登録が完了しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(session[:user_id])
  end

  def edit
    @user = User.find(session[:user_id])
  end

  def update
    @user = User.find(session[:user_id])
    if @user.update(user_params)
      redirect_to user_path, notice: "情報を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(session[:user_id])
    @user.destroy
    redirect_to root_path, notice: "ユーザーを削除しました"
  end

  private

  def user_params
    params.require(:user).permit(:username, :userimage, :email, :password, :password_confirmation)
  end

end
