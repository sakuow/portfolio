class Admin::TagnamesController < ApplicationController

  def index
    @tag = Tagname.new
    @tags = Tagname.all
  end

  def create
    tag = Tagname.new(tagname_params)
    if tag.save
      redirect_to admin_tagnames_path
    else
      render :index
    end
  end

  def edit
    @tag = Tagname.find(params[:id])
  end

  def destroy
    tag = Tagname.find(params[:id])
    if tag.destroy
      redirect_to admin_tagnames_path
    else
      render :index
    end
  end

  def update
    tag = Tagname.find(params[:id])
    if tag.update(tagname_params)
      redirect_to admin_tagnames_path
    else
      render :edit
    end
  end

  private
  def tagname_params
    params.require(:tagname).permit(:tag_name)
  end
end

