class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :postage
      t.integer :billing_amount
      t.integer :payment
      t.integer :status
      t.string :shipping_address
      t.string :shipping_name
      t.string :shipping_postalcode
      t.integer :customer_id
      t.timestamps
    end
  end
end
