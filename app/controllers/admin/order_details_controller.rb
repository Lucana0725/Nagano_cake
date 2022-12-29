class Admin::OrderDetailsController < ApplicationController
  # 提出上、最悪実装の必要はない。
  
  def update
    # byebug
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(create_status_params)
    redirect_to admin_order_path
  end
  
  private
  def create_status_params
    params.require(:order_detail).permit(:create_status)
  end
end
