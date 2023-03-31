class Admin::ItemsController < ApplicationController

  def new
    @item = Item.new
    @genre = Genre.all
  end

  def create
    @item = Item.new(item_params)
    @genre = Genre.all
    @item.save
    if @item.save
    redirect_to admin_item_path(@item.id)
    else
    render :new
    end
  end

  def index
    @item = Item.all
  end

  def edit
  end

  def update
  end

  def show
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :introduction, :price, :is_active, :genre_id)
  end
end