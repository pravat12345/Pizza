class CreateToppings < ActiveRecord::Migration[7.1]
  def change
    create_table :toppings do |t|
      t.string :name
      t.integer :category
      t.decimal :price

      t.timestamps
    end
  end
end
