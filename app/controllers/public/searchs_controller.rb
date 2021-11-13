class Public::SearchsController < ApplicationController

  def search
    @model = params["model"]
    @content = params["content"]
    @method = params["method"]
    search_datas = search_for(@model, @content, @method)
    @datas = Kaminari.paginate_array(search_datas).page(params[:page])
  end

private

  def search_for(model, content, method)
    if model == 'user'
      if method == 'perfect'
        User.where(name: content)
      else
        User.where('name LIKE ?', '%'+content+'%')
      end
    elsif model == 'article'
      if method == 'perfect'
        Article.where(title: content)
      else
        Article.where('title LIKE ?', '%'+content+'%')
      end
    end
  end

end
