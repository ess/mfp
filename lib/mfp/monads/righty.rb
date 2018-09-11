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
          obj.call(*vargs)
        end
      end

      def value_or(_val = nil)
        value
      end

      def or_fmap(*)
        self
      end

      def tee(*args, &block)
        bind(*args, &block).bind {self}
      end
    end

  end
end
