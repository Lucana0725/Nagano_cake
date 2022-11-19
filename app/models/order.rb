class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy
  
  # enumを使って支払い方法を分岐。(0: クレカ、1:銀行振り込み)
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum order_status: { waiting_payment: 0, checked_payment: 1, creating: 2, ready_to_send: 3, finished_send: 4 }
end
