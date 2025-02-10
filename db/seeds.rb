# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# db/seeds.rb


# Creating Pizzas

pizzas = [
  { name: 'Deluxe Veggie', category: 0 },

  { name: 'Cheese and Corn', category: 0 },

  { name: 'Paneer Tikka', category: 0 },

  { name: 'Non-Veg Supreme', category: 1 },

  { name: 'Chicken Tikka', category: 1 },

  { name: 'Pepper Barbecue Chicken', category: 1 }
]


pizzas.each do |pizza|
  Pizza.create!(pizza)
end


# Creating Pizza Variants

pizza_variants = [
  { variant: 'Regular', price: 150, pizza_id: Pizza.find_by(name: 'Deluxe Veggie').id, stock: 10 },

  { variant: 'Medium', price: 200, pizza_id: Pizza.find_by(name: 'Deluxe Veggie').id, stock: 10 },

  { variant: 'Large', price: 325, pizza_id: Pizza.find_by(name: 'Deluxe Veggie').id, stock: 10 },

  

  { variant: 'Regular', price: 175, pizza_id: Pizza.find_by(name: 'Cheese and Corn').id, stock: 10 },

  { variant: 'Medium', price: 375, pizza_id: Pizza.find_by(name: 'Cheese and Corn').id, stock: 10 },

  { variant: 'Large', price: 475, pizza_id: Pizza.find_by(name: 'Cheese and Corn').id, stock: 10 },


  { variant: 'Regular', price: 160, pizza_id: Pizza.find_by(name: 'Paneer Tikka').id, stock: 10 },

  { variant: 'Medium', price: 290, pizza_id: Pizza.find_by(name: 'Paneer Tikka').id, stock: 10 },

  { variant: 'Large', price: 340, pizza_id: Pizza.find_by(name: 'Paneer Tikka').id, stock: 10 },

  

  { variant: 'Regular', price: 190, pizza_id: Pizza.find_by(name: 'Non-Veg Supreme').id, stock: 10 },

  { variant: 'Medium', price: 325, pizza_id: Pizza.find_by(name: 'Non-Veg Supreme').id, stock: 10 },

  { variant: 'Large', price: 425, pizza_id: Pizza.find_by(name: 'Non-Veg Supreme').id, stock: 10 },
  

  { variant: 'Regular', price: 210, pizza_id: Pizza.find_by(name: 'Chicken Tikka').id, stock: 10 },

  { variant: 'Medium', price: 370, pizza_id: Pizza.find_by(name: 'Chicken Tikka').id, stock: 10 },

  { variant: 'Large', price: 500, pizza_id: Pizza.find_by(name: 'Chicken Tikka').id, stock: 10 },

  
  { variant: 'Regular', price: 220, pizza_id: Pizza.find_by(name: 'Pepper Barbecue Chicken').id, stock: 10 },

  { variant: 'Medium', price: 380, pizza_id: Pizza.find_by(name: 'Pepper Barbecue Chicken').id, stock: 10 },

  { variant: 'Large', price: 525, pizza_id: Pizza.find_by(name: 'Pepper Barbecue Chicken').id, stock: 10 }
]


pizza_variants.each do |variant|
 PizzaVariant.create!(variant)
end


# Creating Crusts

crusts = %w[New\ hand\ tossed Wheat\ thin\ crust Cheese\ Burst Fresh\ pan\ pizza]


crusts.each do |crust|
  Crust.create!(name: crust)
end


# Creating Toppings

toppings = [

  { name: 'Black Olive', category: 0, price: 20 },
  { name: 'Capsicum', category: 0, price: 25 },
  { name: 'Paneer', category: 0, price: 35 },
  { name: 'Mushroom', category: 0, price: 30 },
  { name: 'Fresh Tomato', category: 0, price: 10 },
  { name: 'Chicken Tikka', category: 1, price: 35 },
  { name: 'Barbeque Chicken', category: 1, price: 45 },
  { name: 'Grilled Chicken', category: 1, price: 40 }
]


toppings.each do |topping|
  Topping.create!(topping)
end


# topping exclusion add
topping_exclusion = [
{
  category: 0,
  topping_id: Topping.find_by(name:"Chicken Tikka").id
},
{
  category: 0,
  topping_id: Topping.find_by(name:"Barbeque Chicken").id
},
{
  category: 0,
  topping_id: Topping.find_by(name:"Grilled Chicken").id
},
{
  category: 1,
  topping_id: Topping.find_by(name:"Paneer").id
}
]

topping_exclusion.each do |exclusion|
 ToppingPizzaExclusion.create!(exclusion)
end


# Creating Extra Cheese

Extra.create!(name: 'Extra Cheese', price: 35)


# Creating Sides

sides = [
  { name: 'Cold Drink', price: 55 },
  { name: 'Mousse Cake', price: 90 }
]


sides.each do |side|
  Side.create!(side)
end


extras = [
    {name: 'Cheese', price: 32},
    {name: 'Mayonise', price: 34}
]

extras.each do |extra|
  Extra.create!(extra)
end

rule_engines = [
  {category: 0, rule_category: 'Topping', type_of_rule: 'Exclusion', values: Topping.where(name: ['Chicken Tikka', 'Barbeque Chicken', 'Grilled Chicken'])
  .pluck(:id)
  .join(','), variantsizes: 'Regular,Medium,Large', count_value: 0,error_message_local_key: 'orders_validate.veg_topping'},

  {category: 1, rule_category: 'Topping', type_of_rule: 'Exclusion', values: Topping.where(name: ['Paneer'])
  .pluck(:id)
  .join(','), variantsizes: 'Regular,Medium,Large', count_value: 0,error_message_local_key: 'orders_validate.non_veg_no_paner_topping'},

  {category: 0, rule_category: 'Crust', type_of_rule: 'Anyone', values: Crust.all
  .pluck(:id)
  .join(','), variantsizes: 'Regular,Medium,Large',count_value: 0 ,error_message_local_key: 'orders_validate.crust'},

  {category: 1, rule_category: 'Crust', type_of_rule: 'Anyone', values: Crust.all
  .pluck(:id)
  .join(','), variantsizes: 'Regular,Medium,Large',count_value: 0 ,error_message_local_key: 'orders_validate.crust'},

  {category: 1, rule_category: 'Topping', type_of_rule: 'Anyone', values: Topping.where(name: ['Chicken Tikka', 'Barbeque Chicken', 'Grilled Chicken'])
  .pluck(:id)
  .join(','), variantsizes: 'Regular,Medium,Large',count_value: 0,error_message_local_key: 'orders_validate.non_veg_anyone'},

  {category: 0, rule_category: 'Topping', type_of_rule: 'Free', values: Topping.where.not(name: ['Chicken Tikka', 'Barbeque Chicken', 'Grilled Chicken'])
  .pluck(:id)
  .join(','), variantsizes: 'Large',count_value: 2,error_message_local_key: ''},

  {category: 1, rule_category: 'Topping', type_of_rule: 'Free', values: Topping.all
  .pluck(:id)
  .join(','), variantsizes: 'Large',count_value: 2,error_message_local_key: ''}
]

# Create RuleEngine entries
rule_engines.each do |rule|
  RuleEngine.create!(rule)
end



require 'securerandom'

# Create or find the API client
api_client = Doorkeeper::Application.find_or_create_by!(name: "My API Client") do |app|
  app.uid = SecureRandom.hex(16) # Generate a random client ID
  app.secret = SecureRandom.hex(32) # Generate a random client secret
  app.redirect_uri = "http://localhost"  # Not needed for client_credentials flow
  app.scopes = ""
  app.confidential = true
end

puts "Client ID: #{api_client.uid}" #96dc78ab61acfd0fd5467349ce315324
puts "Client Secret: #{api_client.secret}" #d856ba8376a0a0398bf7678aeb3eb8b2c14b454b21d32d24bfc517b8a9e98983