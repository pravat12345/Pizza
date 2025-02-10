class CreatePizzas < ActiveRecord::Migration[7.1]
  def change
    create_table :pizzas do |t|
      t.string :name
      t.integer :category

      t.timestamps
    end
  end
end
