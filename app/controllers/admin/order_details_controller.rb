class Admin::OrderDetailsController < ApplicationController
  # before_action :authenticate_admin!

def update
  order_detail = OrderDetail.find(params[:id])
  @order = order_detail.order
  order_detail.update(order_detail_params)
  if  order_detail.making_status == "in_production"
      @order.update(status:2)
  elsif order_detail.making_status == "production_complete"
      @order.update(status:3)
  end
  redirect_to admin_order_path(order_detail.order.id)
end

private

def order_detail_params
  params.require(:order_detail).permit(:making_status)
end

end
