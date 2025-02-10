class PizzaService
    def fetch_pizza
       return Pizza.all.map {|pizza| Pizzadtos:: PizzaResponsedto.new(pizza)}
    end

    def load_customization(requestDto)
        variant = PizzaVariant.where(pizza_id: requestDto[:pizza_id]).map {|variant| Pizzadtos::PizzaVariantResponsedto.new(variant)}
        extra = Extra.all.map {|extra| Pizzadtos:: ExtraResponsedto.new(extra)}
        sides = Side.all.map{|side| Pizzadtos:: SideResponsedto.new(side)}
        toppings = filter_topping(Topping.all.to_a,requestDto).map{|topping| Pizzadtos:: ToppingResponsedto.new(topping)}
        return Pizzadtos:: PizzaCustomizeResponsedto.new(sides,extra,toppings,variant)
    end

    private 

    def filter_topping(toppings, request_dto)
        excluded_ids = ToppingPizzaExclusion.where(category: request_dto[:categoryid]).pluck(:topping_id).to_set
        return toppings.reject { |topping| excluded_ids.include?(topping.id) }
    end
end

