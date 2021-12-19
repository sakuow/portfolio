class Public::ArticlesController < ApplicationController

helper_method :sort_coumn, :sort_direction

  def new
    @article = Article.new
  end

  def timeline
    timeline = Article.where(user_id: [current_user.id, *current_user.following_ids]).order(created_at: :desc)
    @articles = Kaminari.paginate_array(timeline).page(params[:page])
  end

  def index
    sql = %|
      LEFT OUTER JOIN (
      SELECT count(*) AS favorite_count, favorites.article_id
      FROM favorites
      GROUP BY favorites.article_id
      ) AS favorite_sum
      ON articles.id = favorite_sum.article_id
      |
    if params[:tagname_id] != nil && params[:tagname_id].present?
      @articles = Article.joins(sql).joins(:tagnames).where(tagnames: {id: params[:tagname_id]}).order("favorite_sum.favorite_count desc").page(params[:page])
    else
      @articles = Article.joins(sql).order("favorite_sum.favorite_count desc").page(params[:page])
    end
  end

  def show
    @article = Article.find(params[:id])
    @comment = Comment.new
  end

  def map
    @article = Article.find(params[:id])
    image = @article.images.find(params[:image_id])
    @lat = image.latitude || 35.6809591
    @lng = image.longitude || 139.7673068
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    if @article.save
       @article.images.each do |image|
        req = Vision.get_image_data(image)
        if req.size == 2
          image.latitude, image.longitude = req
          image.save
        else
          flash[:alert] = req
          @article.destroy
          render :new
          return
        end
      end
      redirect_to article_path(@article.id)
      flash[:notice] = "投稿しました！"
    else
      render :new
    end
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      @article.images.each do |image|
        req = Vision.get_image_data(image)
        if req.size == 2
          image.latitude, image.longitude = req
          image.save
        else
          flash[:alert] = req
          @article.destroy
          render :new
          return
        end
      end
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
