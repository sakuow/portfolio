class Public::ArticlesController < ApplicationController

helper_method :sort_coumn, :sort_direction

  def new
    @article = Article.new
  end

  # .whereにてログインしているユーザー及び、そのフォローしているユーザーのArticleを.orderにて投稿日時の降順で表示
  def timeline
    timeline = Article.where(user_id: [current_user.id, *current_user.following_ids]).order(created_at: :desc)
    @articles = Kaminari.paginate_array(timeline).page(params[:page])
  end

  # 左外部結合により、Favoriteテーブルを参照して、
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
    # urlから画像のidを取得し、緯度、経度を設定。Vision APIのLANDMARK_DETECTIONにより位置情報が取得できない場合は、東京駅の座標をセットする。
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
      # each分にて一枚づつVision APIに渡す。
      @article.images.each do |image|
        # Vision APIのレスポンスを定義し、SAFE_SEARCH_DETECTIONにて適切であればLANDMARK_DETECTIONにて緯度と経度が配列で返ってくるため、size == 2の処理を行う。
        res = Vision.get_image_data(image)
        if res.size == 2
          image.latitude, image.longitude = res
          image.save
        else
          # SAFE_SEARCH_DETECTIONにて不適切であると判断された場合、文字列で「画像が不適切です」と返るため、elseに入り投稿を削除する処理を行う。
          flash[:alert] = res
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
        # createに同じ
        res = Vision.get_image_data(image)
        if res.size == 2
          image.latitude, image.longitude = res
          image.save
        else
          flash[:alert] = res
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
