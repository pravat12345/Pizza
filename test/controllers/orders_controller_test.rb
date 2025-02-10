require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @client = Doorkeeper::Application.create!(name: "Test Client", confidential: true, redirect_uri: "https://localhost", scopes: "")
    @token = Doorkeeper::AccessToken.create!(application: @client, expires_in: 1.hour, scopes: "")
    @valid_order = {
      order: {
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
      }
    

    @invalid_order = {
      order: {
        customer_name: "Samanta",
        order_items: [
          {
            pizza_id: pizzas(:DeluxeVeggie).id,
            variant_id: pizza_variants(:RegularDeluxeVeggie).id,
            crust_id: crusts(:ThinWheatCrust).id,
            price: 150,
            category:0,
            toppings: [{ topping_id: toppings(:ChickenTikka).id, price: 35 }],
            extras: [{ extra_id: extras(:Cheese).id, price: 32 }]
          }
        ],
        sides: [
          { side_id: sides(:ColdDrink).id, price: 55 },
          { side_id: sides(:Mousse).id, price: 90 }
        ]
       }
    }

    @valid_free_topping = {
      order: {
        customer_name: "Samanta",
        order_items: [
          {
            pizza_id: pizzas(:NonVegSupreme).id,
            variant_id: pizza_variants(:LargeNonVegSupreme).id,
            crust_id: crusts(:ThinWheatCrust).id,
            price: 425,
            category:1,
            toppings: [{ topping_id: toppings(:BlackOlive).id, price: 20 },
            { topping_id: toppings(:ChickenTikka).id, price: 35 }
            
            ],
            extras: [{ extra_id: extras(:Cheese).id, price: 32 }]
          }
        ],
        sides: [
          { side_id: sides(:ColdDrink).id, price: 55 },
          { side_id: sides(:Mousse).id, price: 90 }
        ]
       }
      }

      @invalid_anyone_non_veg_topping = {
      order: {
        customer_name: "Samanta",
        order_items: [
          {
            pizza_id: pizzas(:NonVegSupreme).id,
            variant_id: pizza_variants(:LargeNonVegSupreme).id,
            crust_id: crusts(:ThinWheatCrust).id,
            price: 425,
            category:1,
            toppings: [{ topping_id: toppings(:BlackOlive).id, price: 20 },
            { topping_id: toppings(:ChickenTikka).id, price: 35 },
            { topping_id: toppings(:BarbequeChicken).id, price: 45 }
            ],
            extras: [{ extra_id: extras(:Cheese).id, price: 32 }]
          }
        ],
        sides: [
          { side_id: sides(:ColdDrink).id, price: 55 },
          { side_id: sides(:Mousse).id, price: 90 }
        ]
       }
      }
  end

  test "should place order successfully with valid data" do
    post orderapi_orderPizza_url, params: @valid_order,headers: { Authorization: "Bearer #{@token.token}" },  as: :json
    assert_response :created # 201
  end

 

  test "free two topping" do
    post orderapi_orderPizza_url, params: @valid_free_topping,headers: { Authorization: "Bearer #{@token.token}" },  as: :json
    order = Order.last
    assert_not_nil order, "Order was not created"
    assert_equal 602, order.total_price.to_i, "Total price calculation mismatch"
    assert_response :created # 201
  end

  test "should fail validation for anyone non veg topping" do
    
    post orderapi_orderPizza_url, params: @invalid_anyone_non_veg_topping, headers: { Authorization: "Bearer #{@token.token}" },  as: :json
    assert_response :unprocessable_entity # 422
    json_response = JSON.parse(response.body)
    assert_equal "Non veg pizza should have only one non veg topping", json_response["message"] # Assuming this is the error message
  end

  test "should fail validation for restricted topping" do
    #binding.break
    post orderapi_orderPizza_url, params: @invalid_order,headers: { Authorization: "Bearer #{@token.token}" },  as: :json
    assert_response :unprocessable_entity # 422
    json_response = JSON.parse(response.body)
    assert_equal "Topping should contain only veg for veg pizza", json_response["message"] # Assuming this is the error message
  end

end



