module MFP
  module Monads
    class Maybe

      module Mixin
        def Maybe(value)
          Maybe.coerce(value)
        end

        def Some(value = Undefined, &block)
          v = Undefined.default(value, block)
          raise ArgumentError, 'No value given' if !value.nil? && v.nil?
          Some.new(v)
        end

        def None
          None.new
        end
      end

    end
  end
end
