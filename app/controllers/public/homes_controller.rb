class Public::HomesController < ApplicationController
  def top
    @item = Item.first(4)
    @genres = Genre.all
  end
  
  def image
    @image = Post.where(image_id: current_image.id).where.not(image: nil)
  end
  
  def about
  end
end
