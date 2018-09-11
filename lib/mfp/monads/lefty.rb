require 'mfp/monads/errors'
require 'mfp/monads/unit'

module MFP
  module Monads

    module Lefty
      def value!
        raise UnwrapError.new(self)
      end

      def bind(*)
        self
      end

      def tee(*)
        self
      end

      def fmap(*)
        self
      end

      def or(*)
        raise NotImplementedError
      end

      def or_fmap(*)
        raise NotImplementedError
      end

      def value_or(val = nil)
        if block_given?
          yield @wrapped
        else
          val
        end
      end

      def discard
        fmap {Unit}
      end
    end

  end
end
