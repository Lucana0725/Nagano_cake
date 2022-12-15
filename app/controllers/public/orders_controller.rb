class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def confirm
    @order = Order.new(order_params)  # ストロングパラメーターから各情報(フォームから送られてきた:postal_code, :address, :name)が送られ、それが@orderに代入される
    # binding.pry
    if params[:order][:address_flag] == 0.to_s
      @order.name = current_customer.last_name + current_customer.first_name
      @order.address = current_customer.address
      @order.postal_code = current_customer.postal_code
    elsif params[:order][:address_flag] == 1.to_s
      @address = Address.find(params[:order][:address_id])
      # params[:order][:address_id] # 今回住所として使いたいアドレステーブルのレコードのID
      @order.name = @address.name
      @order.address = @address.address
      @order.postal_code = @address.postal_code
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
  # ストロングパラメーター
  # 「新しい住所」で入力された内容(:posta_code, :address, :name)がフォームで送信されたらここが受け取る。
  # それをconfirmアクションの@order = Order.new(order_params)の引数の部分で自動的に入力、振り分けられる
  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address,:name)
  end
end
