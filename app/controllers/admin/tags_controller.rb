class Admin::TagsController < ApplicationController
  def create
  end

  def index
  end

  def destroy
  end

  def update
  end

  def edit
  end

  private
  def tag_params
    params.require(:tag).permit(:tag_name)
  end
end

