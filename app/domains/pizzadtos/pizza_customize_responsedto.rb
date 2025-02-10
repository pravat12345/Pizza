module Pizzadtos
  class PizzaCustomizeResponsedto
     attr_reader :sides, :extras, :toppings, :variant

     def initialize(sides,extras,toppings,variant)
       @sides = sides
       @extras = extras
       @toppings = toppings
       @variant = variant
     end
  end
end