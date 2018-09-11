require 'mfp/monads/lefty'
require 'mfp/monads/maybe'
require 'mfp/monads/result/success'
require 'mfp/equalizer'

module MFP
  module Monads
    class Result

      class Failure < Result
        include Lefty

        def initialize(to_wrap)
          super
          freeze
        end

        def ==(other)
          Equalizer.operator(self, other, :failure)
        end

        def eql?(other)
          Equalizer.predicate(self, other, :failure)
        end

        def failure?
          true
        end

        def failure
          wrapped
        end

        def or(*args)
          if block_given?
            yield(wrapped, *args)
          else
            args.first
          end
        end

        def or_fmap(*args, &block)
          Success.new(self.or(*args, &block))
        end

        def to_s
          "Failure(#{wrapped.inspect})"
        end
        alias_method :inspect, :to_s

        def failure
          wrapped
        end

        def flip
          Success.new(wrapped)
        end

        def to_maybe
          Maybe::None.new
        end

        def result(f, _)
          f.call(wrapped)
        end

        def ===(other)
          Failure === other && failure === other.failure
        end
      end

    end
  end
end
