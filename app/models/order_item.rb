class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :pizza
  belongs_to :pizza_variant
  belongs_to :crust
  has_many :order_toppings
  has_many :order_extras
end
