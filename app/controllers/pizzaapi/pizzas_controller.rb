module Pizzaapi

    class PizzasController < ApplicationController
        def fetch_pizza
          pizzas = PizzaService.new().fetch_pizza
          render json: pizzas
        end

        def load_customization
           customized_items = PizzaService.new().load_customization(load_customization_params)
           render json:customized_items
        end

        private
        def load_customization_params
          params.permit(:categoryid,:pizza_id)
        end

    end

end    
