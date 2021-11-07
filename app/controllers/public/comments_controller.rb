class Public::CommentsController < ApplicationController
  def create
    article = Article.find(params[:article_id])
    comment = Comment.new(comment_params)
    comment.user_id = current_user.id
    comment.article_id = article.id
    comment.save
    redirect_to article_path(article)
  end

  def destroy
    Comment.find_by(id: params[:id]).destroy
    redirect_to article_path(params[:article_id])
  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end
end
