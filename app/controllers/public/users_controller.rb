class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def index
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "ユーザー情報が上書きされました"
      redirect_to user_path(current_user.id)
    else
      render "edit"
    end
  end

  def myindex
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image_id)
  end
end
