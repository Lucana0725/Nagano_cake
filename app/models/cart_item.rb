class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item
  
  # 小計を求めるメソッド。今回はカート内商品のページでしか使わないため、CartItemに記述。
  # Itemとアソシエーションを結んでいるため、get_subtotal_priceメソッド内でitem.get_tax_in_priceとしてあげることで
  # Item内に記述した税込み価格を求めるメソッドを使うことができる。
  def get_subtotal_price
    item.get_tax_in_price * amount
  end
end
