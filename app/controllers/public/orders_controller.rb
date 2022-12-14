class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def check
    byebug
    @order = Order.new
    if params[:order][:address_flag] == 0.to_s
      @order.name = current_cutomer.last_name
      @order.address = a
      @order.postal_code = a
    elsif params[:order][:address_flag] == 1.to_s
      @address = Address.find(params[:order][:address_id])
      params[:order][:address_id] # 今回住所として使いたいアドレステーブルのレコードのID
      @order.name = @address.name
      @order.address = a
      @order.postal_code = a
    end
  end

  def finish
  end

  def create
  end

  def index
  end

  def show
  end

  private
  def order_params
    params.require(order).permit(:name)
  end
end
