class CreateRuleEngines < ActiveRecord::Migration[7.1]
  def change
    create_table :rule_engines do |t|
      t.integer :category
      t.string :rule_category
      t.string :type_of_rule
      t.string :values
      t.string :variantsizes
      t.integer :count_value
      t.string  :error_message_local_key

      t.timestamps
    end
  end
end
