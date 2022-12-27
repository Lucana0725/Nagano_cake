class Admin::HomesController < ApplicationController
  def top
    # @order_details = OrderDetail.all
    @orders = Order.all  # 注文の履歴を一覧で出したいのでOrderモデルから全てを引っ張ってくる
    # byebug
    # @order.amount = order_details.amount
    # @ordered_total_amount = 0  # 注文合計の定義や計算はviewの方でやった方がわかりやすいので今回はこちらは却下。
  end
end
