class Public::CustomersController < ApplicationController
  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update!(customer_params)
    redirect_to customer_path
  end

  def unsubscribe
    # @customer = Customer.find(params[:id])
    @customer = Customer.find(current_customer.id)
  end

  def withdrawal
    # @customer = Customer.find(params[:id])
    @customer = Customer.find(current_customer.id)
    # if @customer.is_deleted = false
    #   return @customer.is_deleted = true
    # end
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end


  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email)
  end
end
