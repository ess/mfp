module MFP
  module Monads

    module Righty
      def or(*)
        self
      end

      def value
        @wrapped
      end
      alias_method :value!, :value

      def bind(*args)
        vargs = [value]

        if block_given?
          yield(*vargs, *args)
        else
          obj, *rest = args
          obj.(*vargs, *rest)
        end
      end
    end

  end
end
