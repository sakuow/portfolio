class Public::ArticlesController < ApplicationController
  def new
    @article = Article.new
    @images = Image.new
  end

  def timeline
  end

  def index
    @articles = Article.includes(:favorited_users).sort {|a,b| b.favorited_users.size <=> a.favorited_users.size}
  end

  def show
    @article = Article.find(params[:id])
    # @image = EXIFR::JPEG.new(params[:id])
    # @image.latitude = image.gps.latitude
    # @image.longitude = image.gps.longitude
    @user = current_user
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    if @article.save
      redirect_to article_path(@article.id)
    else
      render :new
    end
  end

  def update
  end

  def destroy
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, images_files: [])
  end

end
