class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item
  
  enum create_status: { cannot_to_start: 0,  waiting_creating: 1, creating: 2, finished: 3}
end
