module Orderdtos
    class OrderValidateResponsedto
        attr_reader :isvalid, :error_message_local_key

        def initialize(isvalid,error_message_local_key)
          @isvalid =isvalid
          @error_message_local_key = error_message_local_key
        end
    end
end