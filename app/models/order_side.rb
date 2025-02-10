class OrderSide < ApplicationRecord
  belongs_to :order
  belongs_to :side
end
