class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def confirm
    @order = Order.new(order_params)  # ストロングパラメーターから各情報(フォームから送られてきた:postal_code, :address, :name)が送られ、それが@orderに代入される。
    @total_price = 0
    # binding.pry
    # byebug
    # @cart_items = CartItem.find(params[:id])
    # @cart_items = CartItem.all  # カート内商品を表示したいので、ここでも@cart_itemsを定義する必要がある。全ての情報がほしいので@cart_items = CartItem.all
    @cart_items = current_customer.cart_items
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

  def create
    # byebug
    @order = Order.new(order_create_params)
    @order.save
    @cart_items = current_customer.cart_items  # 参照するのは現在ログインしているcustomerのカート内商品のみ。
    @cart_items.each do |cart_item|  # カート内商品を一つずつ取り出して、
      @order_detail = OrderDetail.new  # OrderDetailモデルの空のインスタンスを作成し、
      
      # 以下、OrderDetailモデルのカラムに必要な情報を入れていってあげる
      @order_detail.order_id = @order.id
      @order_detail.item_id = cart_item.item.id
      @order_detail.price_with_tax = cart_item.item.get_tax_in_price
      @order_detail.amount = cart_item.amount
      @order_detail.save  # OrderDetailモデルに保存。ここまでが一つのカート内商品に対して起こり、カート内商品全てに適用するまで続く(each)
    end
    @cart_items.destroy_all
    redirect_to orders_thanks_path
  end

  def thanks
  end

  def index
    @orders = Order.all
    @order_detial = OrderDetail.all
    @cart_items = current_customer.cart_items
  end

  def show
  end

  private
  # ストロングパラメーター
  # 「新しい住所」で入力された内容(:posta_code, :address, :name)がフォームで送信されたらここが受け取る。
  # それをconfirmアクションの@order = Order.new(order_params)の引数の部分で自動的に入力、振り分けられる
  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name)
  end

  def order_create_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :postage, :total_payment, :payment_method)
  end
end
