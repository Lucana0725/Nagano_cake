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
    @cart_item = CartItem.find(params[:id])
    @cart_item.update!(cart_item_params)
    redirect_to cart_items_path
    # @cart_item = CartItem.find(params[:id])
    # existed_item = CartItem.find_by(item_id: @cart_item.id, customer_id: current_customer.id)
    # existed_item_amount = existed_item.amount
    # new_amount = existed_item_amount + @cart_item.amount
    # existed_item_amount.update!(amount: new_amount)
    # redirect_to cart_items_path
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


    # if Item.find_by(name: params[:name])
    # if CartItem.find_by(item_id: params[:item_id])

    # 既にカートに存在する商品(existed_item)を定義する。
    # 定義内容：カート内商品のidと、アソシエーションを結んでいるcustomerのidで判別するため。
    existed_item = CartItem.find_by(item_id: @cart_item.item_id, customer_id: current_customer.id)
    # binding.pry

    if existed_item  # カートに商品が存在したら
      new_amount = existed_item.amount + @cart_item.amount  # すでにある商品の数量に、フォームから飛んできたデータ(数量)を足し合わせ、それをnew_amountという変数で保持
      existed_item.update!(amount: new_amount)  # すでにある商品(existed_item)を更新。（amountカラムを、足し合わせた数量(new_amount)で更新）
      redirect_to cart_items_path
    else
      @cart_item.save!
      redirect_to cart_items_path
    end
    # 以下if文追記前元の記述
    # @cart_item.save!
    # redirect_to cart_items_path
  end


  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
