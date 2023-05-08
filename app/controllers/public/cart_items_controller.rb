class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items
  end

  def create
    @cartitem = CartItem.new(cart_item_params)
    @cart_items = current_customer.cart_items
    @cartitem.customer_id = current_customer.id
    @cart_items.each do |cart_item|
      if cart_item.item_id == @cartitem.item_id
        new_amount = cart_item.amount + @cartitem.amount
        cart_item.update_attribute(:amount,new_amount)
        @cartitem.delete
      end
    end
      @cartitem.save
      flash[:success] = ""
      redirect_to cart_items_path
  end
  
  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end
  
  def destroy_all
    @cart_item = current_customer.cart_items
    @cart_item.destroy_all
    redirect_to cart_items_path
  end

  private

  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
  end
end
