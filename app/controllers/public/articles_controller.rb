class Public::ArticlesController < ApplicationController
  def new
  end
  
  def timeline
  end
  
  def index
  end
  
  def show
  end
  
  def edit
  end
  
  def create
  end
  
  def update
  end
  
  def destroy
  end
  
  private
  
  def article_params
    params.require(:article).permit(:title, :body)
  end
  
end
