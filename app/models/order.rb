class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy
  
  # enumを使って支払い方法を分岐。(0: クレカ、1:銀行振り込み)
  enum payment_method: { credit_card: 0, transfer: 1 }
  # enum status: { }
end
