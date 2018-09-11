require 'mfp/monads/errors'

module MFP
  module Monads

    module Lefty
      def value!
        raise UnwrapError.new(self)
      end

      def bind(*)
        self
      end

      def or(*args)
        if block_given?
          yield @wrapped
        else
          args.first
        end
      end

      def value_or(val = nil)
        if block_given?
          yield @wrapped
        else
          val
        end
      end
    end

  end
end
