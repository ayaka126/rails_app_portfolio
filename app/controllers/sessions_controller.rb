class SessionsController < ApplicationController
  before_action :already_login?, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path, notice: "ログインしました"
    else
      flash.now[:alert] = "emailまたはpasswordが違います"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, status: :see_other
    flash.now[:notice] = "ログアウトしました"
  end
end
