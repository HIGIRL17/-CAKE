class Admin::ItemsController < ApplicationController

  def new
    @item = Item.new
    @genre = Genre.all
  end

  def create
    @item = Item.new(item_params)
    @genre = Genre.all
    if @item.save
      redirect_to admin_item_path(@item.id)
    else
      render :new
    end
  end

  def index
    @item = Item.page(params[:page])
  end

  def edit
    @item = Item.find(params[:id])
    @genre = Genre.all
  end

  def update
     @item = Item.find(params[:id])
    if @item.update(item_params)
       redirect_to admin_item_path
    else
       render :edit
    end
  end

  def show
    @item = Item.find(params[:id])
  end


  private

  def item_params
    params.require(:item).permit(:image, :name, :introduction, :price, :is_active, :genre_id)
  end
end