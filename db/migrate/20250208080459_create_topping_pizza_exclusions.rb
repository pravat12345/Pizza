class CreateToppingPizzaExclusions < ActiveRecord::Migration[7.1]
  def change
    create_table :topping_pizza_exclusions do |t|
      t.integer :category
      t.references :topping, null: false, foreign_key: true

      t.timestamps
    end
  end
end
