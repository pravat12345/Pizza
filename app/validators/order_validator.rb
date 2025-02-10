class OrderValidator
  def initialize(orderRequestDto)
    @order = orderRequestDto
  end
  
  def validate_exclusion_topping
    #binding.break
    isvalid = 1
    error_message_local_key = ''
    @order[:order_items].each do |order_item|
       topping_ids = order_item[:toppings].map { |topping| topping[:topping_id] }
       rules = RuleEngine.where(category: order_item[:category],rule_category: 'Topping', type_of_rule: 'Exclusion')
       rules.each do |rule|
        rule_values = rule.values.split(',').map(&:to_i)
        variant_sizes = rule.variantsizes.split(',').map(&:strip)
        pizza_variant  = PizzaVariant.find_by(id: order_item[:variant_id])
        if !pizza_variant.nil? 
            if variant_sizes.include?(pizza_variant.variant)
                if (topping_ids & rule_values).any? #intersection of 2 arrays if present it means topping is present in rule values
                  return Orderdtos::OrderValidateResponsedto.new(0,rule.error_message_local_key)
                end
            end
        else
            return Orderdtos::OrderValidateResponsedto.new(0,'orders_validate.no_valid_variant')      
        end
       end
    end
    return Orderdtos::OrderValidateResponsedto.new(1,'')
  end

  def validate_anyone_crust
    #binding.break
    isvalid = 1
    error_message_local_key = ''
    @order[:order_items].each do |order_item|
       crust_id = order_item[:crust_id]
       rules = RuleEngine.where(category: order_item[:category],rule_category: 'Crust', type_of_rule: 'Anyone')
       rules.each do |rule|
        rule_values = rule.values.split(',').map(&:to_i)
        variant_sizes = rule.variantsizes.split(',').map(&:strip)
        pizza_variant  = PizzaVariant.find_by(id: order_item[:variant_id])
       if !pizza_variant.nil?
        if variant_sizes.include?(pizza_variant.variant)
            if !rule_values.include?(crust_id)
               return Orderdtos::OrderValidateResponsedto.new(0,rule.error_message_local_key)
            end
        end
       else
        return Orderdtos::OrderValidateResponsedto.new(0,'orders_validate.no_valid_variant')
       end
     end
    end
    return Orderdtos::OrderValidateResponsedto.new(1,'')
  end

  def validate_anyone_topping
    #binding.break
    isvalid = 1
    error_message_local_key = ''
    @order[:order_items].each do |order_item|
      topping_ids = order_item[:toppings].map { |topping| topping[:topping_id] }
       rules = RuleEngine.where(category: order_item[:category],rule_category: 'Topping', type_of_rule: 'Anyone')
       rules.each do |rule|
            rule_values = rule.values.split(',').map(&:to_i)
            variant_sizes =rule.variantsizes.split(',').map(&:strip)
            pizza_variant  = PizzaVariant.find_by(id: order_item[:variant_id])
           if !pizza_variant.nil?
            if variant_sizes.include?(pizza_variant.variant)
                if (topping_ids & rule_values).size != 1 #intersection of 2 arrays if intersection should have only one
                    return Orderdtos::OrderValidateResponsedto.new(0,rule.error_message_local_key)
                end
            end
          else
            return Orderdtos::OrderValidateResponsedto.new(0,'orders_validate.no_valid_variant')
          end
       end
    end
    return Orderdtos::OrderValidateResponsedto.new(1,'')
  end

  def free_topping
    #binding.break
    @order[:order_items].each do |order_item|
        rules = RuleEngine.where(category: order_item[:category],rule_category: 'Topping', type_of_rule: 'Free')
        rules.each do |rule|
        variant_sizes = rule.variantsizes.split(',').map(&:strip)
        pizza_variant  = PizzaVariant.find_by(id: order_item[:variant_id]) 
        if  !pizza_variant.nil? && variant_sizes.include?(pizza_variant.variant)
            toppings = order_item["toppings"]
            if(toppings.size > rule.count_value)
                lowest_toppings = toppings.sort_by { |t| t["price"] }.first(rules.count_value)
            else
                lowest_toppings = toppings 
            end
            lowest_toppings.each { |t| t["price"] = 0 }
            end
        end    
    end
    return @order
  end
end