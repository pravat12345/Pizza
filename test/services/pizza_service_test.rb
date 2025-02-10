require 'test_helper'

class PizzaServiceTest < ActiveSupport::TestCase

  def setup
    @service = PizzaService.new
    @vegpizza = pizzas(:DeluxeVeggie)
    @nonvegpizza = pizzas(:NonVegSupreme)
    @requestVeg = {pizza_id: @vegpizza.id,categoryid: @vegpizza.category}
    @requestNonVeg = {pizza_id: @nonvegpizza.id,categoryid: @nonvegpizza.category}
  end

  def test_fetch_pizza
    response = @service.fetch_pizza
    assert_not_empty response
    assert_equal response.length, 2
    assert_instance_of Pizzadtos::PizzaResponsedto, response.first
    # veg pizza test
    filtered_veg_pizza = response.select {|pizza| pizza.pizza_name == 'Deluxe Veggie'}
    assert_not_empty filtered_veg_pizza
   
    assert_equal @vegpizza.name, filtered_veg_pizza.first.pizza_name, "Name of pizza should match"
    assert_equal @vegpizza.category, filtered_veg_pizza.first.category, "Category should be match" 

    #non veg pizza
    filtered_nonveg_pizza = response.select {|pizza| pizza.pizza_name == 'Non-Veg Supreme'}
    assert_not_empty filtered_nonveg_pizza
  
    assert_equal @nonvegpizza.name, filtered_nonveg_pizza.first.pizza_name, "Name of pizza should match"
    assert_equal @nonvegpizza.category, filtered_nonveg_pizza.first.category, "Category should be match"  

  end

  def test_load_customization
   
    #vegetarian
    responseVeg = @service.load_customization(@requestVeg)

    assert_not_nil responseVeg, "Response should not be nil"
    # Checking Sides
    assert_not_empty responseVeg.sides, "Sides should not be empty"
    assert_equal responseVeg.sides.length, 2, "Expected 2 sides"
    assert_instance_of Pizzadtos::SideResponsedto, responseVeg.sides.first
    assert_equal responseVeg.sides.first.side_name, "Cold Drink", "Name should be Cold Drink"
    assert_equal responseVeg.sides.first.price.to_i, 55, "Price is not matching"

    # Checking Toppings
    assert_not_empty responseVeg.toppings, "Toppings should not be empty"
    assert_equal responseVeg.toppings.length, 2, "Expected 2 toppings"
    assert_instance_of Pizzadtos::ToppingResponsedto, responseVeg.toppings.first
    oliveTopping = responseVeg.toppings.select {|topping| topping.topping_name == "Black Olive"}
    assert_not_empty oliveTopping , "Name should be Black Olive"
    assert_equal oliveTopping.first.price.to_i, 20, "Price is not matching"

    # Checking Variants
    assert_not_empty responseVeg.variant, "Variants should not be empty"
    assert_equal responseVeg.variant.length, 3, "Expected 3 variants"
    assert_instance_of Pizzadtos::PizzaVariantResponsedto, responseVeg.variant.first
    assert_equal responseVeg.variant.first.variant, "Regular", "Name should be Regular"
    assert_equal responseVeg.variant.first.price.to_i, 150, "Price is not matching"

    # Checking Extras
    assert_not_empty responseVeg.extras, "Extras should not be empty"
    assert_equal responseVeg.extras.length, 1, "Expected 1 extra"
    assert_instance_of Pizzadtos::ExtraResponsedto, responseVeg.extras.first
    assert_equal responseVeg.extras.first.extra_name, "Cheese", "Name should be Cheese"
    assert_equal responseVeg.extras.first.price.to_i, 32, "Price is not matching"


    #non-veg
    responseNonVeg = @service.load_customization(@requestNonVeg)
    assert_not_nil responseNonVeg, "Response should not be nil"
    # Checking Toppings only for non-veg
    assert_not_empty responseNonVeg.toppings, "Toppings should not be empty"
    assert_equal responseNonVeg.toppings.length, 3, "Expected 3 toppings"
    assert_instance_of Pizzadtos::ToppingResponsedto, responseNonVeg.toppings.first
    chikenTopping = responseNonVeg.toppings.select {|topping| topping.topping_name == "Chicken Tikka"}
    assert_not_empty chikenTopping , "Name should be Chicken Tikka"
    assert_equal chikenTopping.first.price.to_i, 35, "Price is not matching"

    pannerTopping = responseNonVeg.toppings.select {|topping| topping.topping_name == "Paneer"}
    assert_empty pannerTopping , "paneer topping should present"

  end
     
end