class Public::RelationshipsController < ApplicationController
  
  # 非同期化
  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end

  # 非同期化
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end

  # フォロー一覧
  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end

  # フォロワー
  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end
end
