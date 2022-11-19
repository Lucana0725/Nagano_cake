class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_items
  
  has_one_attached :image
  
  def get_item_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no-image.jpg')
      image.attached(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end
end
