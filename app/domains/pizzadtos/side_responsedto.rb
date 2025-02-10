module Pizzadtos
  class SideResponsedto
    attr_reader :id,:side_name,:price
    def initialize(side)
      @id = side.id
      @side_name = side.name
      @price = side.price
    end
  end

end