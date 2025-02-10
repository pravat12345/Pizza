module Pizzadtos
  class ToppingResponsedto
    attr_reader :id, :topping_name, :price
    
    def initialize(topping)
      @id = topping.id
      @topping_name = topping.name
      @price = topping.price
    end

  end

end