class Public::CommentsController < ApplicationController

  # 非同期化
  def create
    @article = Article.find(params[:article_id])
    comment = Comment.new(comment_params)
    comment.user_id = current_user.id
    comment.article_id = @article.id
    comment.save
    @new_comment = Comment.new
  end

  # 非同期化
  def destroy
    @article = Article.find(params[:article_id])
    comment = @article.comments.find(params[:id])
    comment.destroy
    @new_comment = Comment.new
  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end
end
