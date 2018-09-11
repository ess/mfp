require 'mfp/monads/righty'
require 'mfp/equalizer'

module MFP
  module Monads
    class Maybe

      class Some < Maybe
        include Righty

        def ==(other)
          Equalizer.operator(self, other, :value!)
        end

        def eql?(other)
          Equalizer.predicate(self, other, :value!)
        end

        def ===(other)
          Some === other && value! === other.value!
        end

        def some?
          true
        end
        alias_method :success?, :some?

        def none?
          false
        end
        alias_method :failure?, :none?

        def fmap(*args, &block)
          self.class.coerce(bind(*args, &block))
        end

        def to_s
          "Some(#{wrapped.inspect})"
        end
        alias_method :inspect, :to_s

      end

    end
  end
end
