require 'mfp/monads/righty'
require 'mfp/monads/result/failure'
require 'mfp/equalizer'

module MFP
  module Monads
    class Result

      class Success < Result
        include Righty

        def ==(other)
          Equalizer.operator(self, other, :value!)
        end

        def eql?(other)
          Equalizer.predicate(self, other, :value!)
        end

        def ===(other)
          Success === other && value! === other.value!
        end

        def success?
          true
        end

        def fmap(*args, &block)
          Success.new(bind(*args, &block))
        end

        def to_s
          "Success(#{wrapped.inspect})"
        end

        def flip
          Failure.new(wrapped)
        end

        alias_method :success, :value!
        alias_method :inspect, :to_s
      end

    end
  end
end
