class Public::ItemsController < ApplicationController
  before_action :authenticate_customer!,except: [:top, :about, :index, :show]

  def index
    @items = Item.all.page(params[:page]).per(8)
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
    @cart_item = CartItem
  end
  
end
