class Public::UsersController < ApplicationController
  before_action :set_user, only: [:favorites]

  def show
    @user = User.find(params[:id])
  end

  # ユーザーのいいね一覧
  def favorites
    # Favoriteテーブル内のurlから取得したuser_idの投稿を配列で取り出しfavorite、それをもとにArticleテーブルから該当する投稿を取り出す。
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:article_id)
    article = Article.find(favorites)
    @articles = Kaminari.paginate_array(article).page(params[:page])
  end

  # ユーザーの投稿一覧
  def myindex
    @user = User.find(params[:id])
    kaminari = @user.articles
    @articles = Kaminari.paginate_array(kaminari).page(params[:page])
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

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
