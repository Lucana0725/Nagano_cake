class Public::AddressesController < ApplicationController
  def index
    @address = Address.new
    # @addresses = Address.all
    @addresses = current_customer.addresses
  end

  def edit
    # @address.customer_id = current_customer.id
    # byebug
    # @addresses = current_customer.addresses
    @address = Address.find(params[:id])
    # @address = @addresses.find(params[:id])
  end

  def create
    # @address.customer.id = current_customer.id
    # @address = current_customer.address
    # byebug
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id  #byebugでデバッグしたら@address.saveの直前のところで"@address"とすると"customer_id: nill"と出たのでおそらく必要。 書く順番に注意。(@address.newの前に)
    @address.save!
    redirect_to addresses_path
  end

  def update
    # byebug
    @address = Address.find(params[:id])
    @address.update(address_params)
    redirect_to addresses_path
  end

  def destroy
  end
  
  
  private
  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end
end
