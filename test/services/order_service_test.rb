require 'test_helper'

class OrderServiceTest < ActiveSupport::TestCase
    def setup
      @service = OrderService.new
      @request_dto = {
        customer_name: "Samanta",
        order_items: [
          {
            pizza_id: pizzas(:DeluxeVeggie).id,
            variant_id: pizza_variants(:RegularDeluxeVeggie).id,
            crust_id: crusts(:ThinWheatCrust).id,
            price: 150,
            category:0,
            toppings: [{ topping_id: toppings(:BlackOlive).id, price: 20 }],
            extras: [{ extra_id: extras(:Cheese).id, price: 32 }]
          }
        ],
        sides: [
          { side_id: sides(:ColdDrink).id, price: 55 },
          { side_id: sides(:Mousse).id, price: 90 }
        ]
      }
    end
  
    def test_order_pizza
      response = @service.order_pizza(@request_dto)
  
      assert_equal 1, response.status, "Order creation failed"
  
      order = Order.last
      assert_not_nil order, "Order was not created"
      assert_equal "Samanta", order.customer_name, "Customer name mismatch"
      assert_equal 150 + 20 + 32 + 55 + 90, order.total_price.to_i, "Total price calculation mismatch"
  
      assert_equal 1, order.order_items.count, "Incorrect number of order items"
      order_item = order.order_items.first
      assert_equal 150 + 20 + 32, order_item.price.to_i, "Order item price mismatch"
      assert_equal pizzas(:DeluxeVeggie).id, order_item.pizza_id, "Pizza mismatch"
  
      assert_equal 1, order_item.order_toppings.count, "Incorrect number of toppings"
      assert_equal toppings(:BlackOlive).id, order_item.order_toppings.first.topping_id, "Topping ID mismatch"
  
      assert_equal 1, order_item.order_extras.count, "Incorrect number of extras"
      assert_equal extras(:Cheese).id, order_item.order_extras.first.extra_id, "Extra ID mismatch"
  
      assert_equal 2, order.order_sides.count, "Incorrect number of sides"
    end
  end