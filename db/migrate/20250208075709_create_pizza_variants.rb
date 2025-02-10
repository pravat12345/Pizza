class CreatePizzaVariants < ActiveRecord::Migration[7.1]
  def change
    create_table :pizza_variants do |t|
      t.string :variant
      t.decimal :price
      t.references :pizza, null: false, foreign_key: true
      t.integer :stock

      t.timestamps
    end
  end
end
