module Pizzadtos
  class ExtraResponsedto
    attr_reader :id,:extra_name,:price

    def initialize(extra)
        @id = extra.id
        @extra_name = extra.name
        @price = extra.price
    end
  end
end