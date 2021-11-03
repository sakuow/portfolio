class Public::UsersController < ApplicationController
  def show
  end
  
  def edit
  end
  
  def update
  end
  
  def myindex
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image_id)
  end
end
