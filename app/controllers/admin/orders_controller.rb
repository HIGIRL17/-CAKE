class Admin::OrdersController < ApplicationController
  def show
    @orders = Order.all
    @order = Order.find(params[:id])
    @order_details = OrderDetail.all
    @order_detail = @order.order_details
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    if  @order.status == "confirm_payment"
        @item = @order.order_details
        @item.each do |item|
        item.update(making_status:1)
        end
    end
    redirect_to admin_order_path(@order)
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end

end
