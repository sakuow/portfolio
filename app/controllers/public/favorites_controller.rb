class Public::FavoritesController < ApplicationController
  
  # 非同期化
  def create
    @article = Article.find(params[:article_id])
    favorite = current_user.favorites.new(article_id: @article.id)
    favorite.save
  end


  # 非同期化
  def destroy
    @article = Article.find(params[:article_id])
    favorite = current_user.favorites.find_by(article_id: @article.id)
    favorite.destroy
  end

end
