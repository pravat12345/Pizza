class CreateOrderItems < ActiveRecord::Migration[7.1]
  def change
    create_table :order_items do |t|
      t.references :order, null: false, foreign_key: true
      t.references :pizza, null: false, foreign_key: true
      t.references :pizza_variant, null: false, foreign_key: true
      t.references :crust, null: false, foreign_key: true
      t.decimal :price
      t.integer :qty

      t.timestamps
    end
  end
end
