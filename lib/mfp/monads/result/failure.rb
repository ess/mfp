module MFP
  module Monads
    class Result

      class Failure < Result
        def initialize(to_wrap)
          super
          freeze
        end

        def failure?
          true
        end

        def or
          yield failure
        end

        def on_failure
          yield failure
          self
        end

        def failure
          wrapped
        end
      end

    end
  end
end
