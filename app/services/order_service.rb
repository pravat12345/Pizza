class OrderService
  def order_pizza(orderRequestDto)
    #binding.break  # Debug before saving
    order = Order.new(customer_name: orderRequestDto[:customer_name],total_price: 0)
    orderRequestDto[:sides]&.each do |side|
        order.order_sides.build(side_id: side[:side_id], price: side[:price])
        order.total_price += side[:price]
    end
    orderRequestDto[:order_items].each do |orderItem|
        order_item =order.order_items.build(pizza_id: orderItem[:pizza_id],pizza_variant_id: orderItem[:variant_id],
        crust_id: orderItem[:crust_id],price: orderItem[:price],qty: orderItem[:qty]
        )
        order.total_price += orderItem[:price]
        orderItem[:toppings].each do |topping|
            order_item.order_toppings.build(topping_id: topping[:topping_id], price: topping[:price])
            order_item.price += topping[:price]
            order.total_price += topping[:price]
        end
        orderItem[:extras].each do |extra|
            order_item.order_extras.build(extra_id: extra[:extra_id], price: extra[:price])
            order_item.price += extra[:price]
            order.total_price += extra[:price]
        end
    end    

    if order.save
        return Orderdtos::OrderResponsedto.new(I18n.t('orders.success'), 1)
    else
        return Orderdtos::OrderResponsedto.new(order.errors.full_messages, 0)
    end
      
  end
end