class Item < ApplicationRecord
  has_one_attached :image
  has_many :cart_items, dependent: :destroy
  belongs_to :genre
  has_many :order_details
  
  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
  validates :image, presence: true
  validates :genre_id, presence: true
  validates :is_active, presence: true

  def add_tax_price
    (self.price * 1.10).round
  end

  def get_image(width,height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end
end
