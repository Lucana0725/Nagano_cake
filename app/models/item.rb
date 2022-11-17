class Item < ApplicationRecord
  has_many :genres, dependent: :destroy
  has_many :cart_items
end
