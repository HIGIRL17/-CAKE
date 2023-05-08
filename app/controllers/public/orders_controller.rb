class Public::OrdersController < ApplicationController

  def new
    if current_customer.cart_items.any?
      @order = Order.new
      @addresses = current_customer.addresses
    else
      redirect_to cart_items_path
    end
  end

  def comfirm
    @cart_items = current_customer.cart_items.all
    @sum = 0
    @order = Order.new(order_params)
    @order.postage = 800
    if params[:order][:select_address] == "0"
       @order.shipping_name  = current_customer.last_name + current_customer.first_name
       @order.shipping_address = current_customer.address
       @order.shipping_postalcode = current_customer.postal_code
    elsif params[:order][:select_address] == "1"
       @address = Address.find(params[:order][:address_id])
       @order.shipping_name = @address.name
       @order.shipping_address =  @address.address
       @order.shipping_postalcode =  @address.postal_code
    elsif params[:order][:select_address] == "2"
    end
  end

  def create
    @cart_items = current_customer.cart_items.all
    @order = current_customer.orders.new(order_params)
    @order.status = 0
    @order.save!
    @cart_items.each do|cart_item|
      order_detail = OrderDetail.new(order_id: @order.id)
      order_detail.item_id = cart_item.item.id
      order_detail.amount = cart_item.amount
      order_detail.price = (cart_item.item.price * 1.1).floor
      order_detail.save!
    end
    @cart_items.destroy_all
    redirect_to orders_complete_path
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @order.postage = 800
    @sum = 0
  end

  private

  def order_params
      params.require(:order).permit(:shipping_name, :shipping_address, :shipping_postalcode, :payment, :postage,:billing_amount,)
  end
end
