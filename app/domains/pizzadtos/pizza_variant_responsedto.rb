module Pizzadtos
  class PizzaVariantResponsedto
   attr_reader :variant_id, :variant, :price
   def initialize(variant)
    @variant_id = variant.id
    @variant = variant.variant
    @price = variant.price
   end

  end
end