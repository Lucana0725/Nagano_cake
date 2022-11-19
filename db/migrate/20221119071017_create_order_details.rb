class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|

      t.integer :order_id      ,  null: false
      t.integer :customer_id   ,  null: false
      t.integer :price_with_tax,  null: false
      t.integer :amount        ,  null: false
      t.integer :create_status ,  null: false, default: 0
      t.timestamps
    end
  end
end
