require 'mfp/monads/lefty'

module MFP
  module Monads
    class Result

      class Failure < Result
        include Lefty

        def initialize(to_wrap)
          super
          freeze
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
