class Public::CartItemsController < ApplicationController
  def index
    # @cart_items = CartItem.all
    # 「current_customer」の「cart_items」を取得する という考え方
    # ユーザーごとのcart_itemsを取ってくるのに、cart_itemとcustomerはアソシエーションを結んでいるので、
    # CartItemというモデル名を指定するのではなく、cart_itemsというテーブル名を指定する
    @cart_items = current_customer.cart_items
    # @cart_items.customer_id = current_customer.id

    # 計算結果を保持する変数だから0で初期化する
    @total_price = 0
  end

  def update
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    # @cart_items = CartItem.all
    @cart_items = current_customer.cart_items
    @cart_items.destroy_all
    redirect_to cart_items_path
  end

  def create
    # Customerとアソシエーションを結んでいるので親になるCustomerの情報(id)が必要になる
    # @cart_item = current_customer.cart_items.new(cart_item_params)  下二行と同じ意味合い。「現在のcustomerのcart_items（Customerモデルでアソシエーションを結んだ際の"has_many :cart_items"をそのまま持ってきて使用）を新しく作りなさいよ」という記述。
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id


    # binding.pry

    @cart_item.save!
    redirect_to cart_items_path
  end


  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
