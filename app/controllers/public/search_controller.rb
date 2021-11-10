class Public::SearchController < ApplicationController

  def search

    @model = params["search"]["model"]
    @value = params["search"]["value"]
    @how = params["search"]["how"]
    search_datas = search_for(@how, @model, @value)
    @datas = Kaminari.paginate_array(search_datas).page(params[:page])
  end

  private

  def match(model, value)
    Article.where(title: value)
  end

  def forward(model, value)
    Article.where("title LIKE ?", "#{value}%")
  end

  def backward(model, value)
    Article.where("title LIKE ?", "%#{value}")
  end

  def partical(model, value)
    Article.where("title LIKE ?", "%#{value}%")
  end

  def search_for(how, model, value)
    case how
    when 'match'
      match(model, value)
    when 'forward'
      forward(model, value)
    when 'backward'
      backward(model, value)
    when 'partical'
      partical(model, value)
    end
  end

end
