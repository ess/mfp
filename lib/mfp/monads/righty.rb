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
          vargs = vargs + args
          yield(*vargs)
        else
          obj, *rest = args
          vargs = vargs + rest
          obj.send(*vargs)
        end
      end
    end

  end
end
