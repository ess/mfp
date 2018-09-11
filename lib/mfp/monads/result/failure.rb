require 'mfp/monads/lefty'
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
      end

    end
  end
end
