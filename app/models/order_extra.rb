class OrderExtra < ApplicationRecord
  belongs_to :order_item
  belongs_to :extra
end
