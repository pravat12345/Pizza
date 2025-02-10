module Pizzadtos
    class PizzaResponsedto
     attr_reader :id, :pizza_name, :category

     def initialize(pizzas)
       @id = pizzas.id
       @pizza_name = pizzas.name
       @category = pizzas.category
     end
     

    end
end
 