class Public::ArticlesController < ApplicationController

helper_method :sort_coumn, :sort_direction
  def new
    @article = Article.new
    @images = Image.new
  end

  def timeline
    timeline = Article.where(user_id: [current_user.id, *current_user.following_ids]).order(created_at: :desc)
    @articles = Kaminari.paginate_array(timeline).page(params[:page])
  end

  def index
    favorite_articles = Article.includes(:favorited_users).sort {|a,b| b.favorited_users.size <=> a.favorited_users.size}
    kaminari = Kaminari.paginate_array(favorite_articles).page(params[:page])
    @articles = params[:tagname_id].present? ? Tagname.find(params[:tagname_id]).posts : kaminari
  end

  def show
    @article = Article.find(params[:id])
    @comment = Comment.new
    # @image = EXIFR::JPEG.new(params[:id])
    # @image.latitude = image.gps.latitude
    # @image.longitude = image.gps.longitude
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    if @article.save
      redirect_to article_path(@article.id)
      flash[:notice] = "投稿しました！"
    else
      render :new
    end
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to article_path(@article.id)
      flash[:notice] = "投稿内容を編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    if @article.destroy
      redirect_to articles_path
      flash[:notice] = "投稿を削除しました！"
    else
      render :show
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, images_files: [], tagname_ids: [])
  end

end
