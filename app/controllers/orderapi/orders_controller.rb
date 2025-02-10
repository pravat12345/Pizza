module Orderapi
  class OrdersController < ApplicationController
    before_action :validate_order_item_rule, only: [:order_pizza]

    def order_pizza
        #binding.break  # Debug before saving
        
        orderplaced = OrderService.new().order_pizza(orderparams)
        if orderplaced.status == 1
            render json: orderplaced.as_json(except: [:status]), status: :created
        else
            render json: orderplaced.as_json(except: [:status]), status: :unprocessable_entity
        end    
        
    end

   private

   def orderparams
      params.require(:order).permit(:customer_name, order_items: [:pizza_id,:variant_id,:crust_id,:price,:qty, :category, toppings: [:topping_id, :price],extras: [:extra_id,:price]],sides: [:side_id, :price])
   end

   def validate_order_item_rule
    
    validator = OrderValidator.new(orderparams)
    
    # Run all validations
    [
      validator.validate_exclusion_topping,
      validator.validate_anyone_crust,
      validator.validate_anyone_topping
    ].each do |response|
      if response.isvalid == 0
        orderplaced = Orderdtos::OrderResponsedto.new(I18n.t(response.error_message_local_key),0)
        render json: orderplaced.as_json(except: [:status]), status: :unprocessable_entity
        return
      end
    end
  
      # Apply free toppings rule (modifies params directly)
      params[:order] = validator.free_topping  
  end


   
  end
end
