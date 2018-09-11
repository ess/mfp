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
          puts "it's failing here"
          obj, *rest = args
          vargs = vargs + rest
          puts "vargs == '#{vargs}'"
          puts "obj == '#{obj}'"
          if obj.respond_to?(:lambda?)
            if obj.lambda?
              if obj.arity < 1
                obj.call
              else
                vargs = vargs.first(obj.arity)
                obj.call(*vargs)
              end
            else
              obj.call(*vargs)
            end
          else
            obj.call(*vargs)
          end
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
