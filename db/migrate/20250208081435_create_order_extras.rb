class CreateOrderExtras < ActiveRecord::Migration[7.1]
  def change
    create_table :order_extras do |t|
      t.references :order_item, null: false, foreign_key: true
      t.references :extra, null: false, foreign_key: true
      t.decimal :price

      t.timestamps
    end
  end
end
