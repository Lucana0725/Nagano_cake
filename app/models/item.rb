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
  
  # 商品詳細ページ(show)で消費税込み価格を表示させるためのメソッド
  # 参考：https://teratail.com/questions/300068
  def get_tax_in_price
    tax_in_price = price * 1.1
    return tax_in_price.floor
  end
end
