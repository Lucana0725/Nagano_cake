class Admin::ItemsController < ApplicationController
  def index
  end

  def new
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end
  
  
  private
  
  def item_params
    params.require(:item).permit(:name, :introduction, :price, :image)
  end
end
