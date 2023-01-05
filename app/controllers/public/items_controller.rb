class Public::ItemsController < ApplicationController
  def index
    @items = Item.all.page(params[:page])
  end

  def show
    @item = Item.find(params[:id])
    # @item_new = Item.new

    # item/showのform_withの飛ばし先(model: @cart_item)で空のインスタンスが必要になる(要はここ(items_controller)とは別のコントローラになる)ので、
    # ここで@cart_item = CartItem.newとして受け皿を作ってあげておかないと、cart_item_controllerのcreateアクションの内容を格納できなくなる
    @cart_item = CartItem.new
  end
end
