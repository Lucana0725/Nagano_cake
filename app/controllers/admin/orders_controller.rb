class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details  # showページ下側のtableで注文内容(OrderDetail)を取り出すために全てのOrderDetailを取得する必要がある。そしてそれは単一のOrderのページにて表示されるので上で定義の@orderにアソシエーションで紐づいている.order_detailsとなる。
  end

  def update
    # byebug
    @order = Order.find(params[:id])
    # @order_detail = @order.order_details.find(params[:id])
    @order.update(order_status_params)
    # if @order_detail.update
    #   @order_detail.update(create_status_params)
    # end
    redirect_to admin_order_path
  end

  private
  def order_status_params
    params.require(:order).permit(:order_status)
  end

  # def create_status_params
  #   params.require(:order_detail).permit(:create_status)
  # end
end
