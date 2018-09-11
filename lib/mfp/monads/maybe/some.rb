module MFP
  module Monads
    class Maybe

      class Some < Maybe
        def bind
          yield value
        end

        def value
          wrapped
        end
        alias_method :value!, :value
        alias_method :value_or, :value

        def some?
          true
        end

        def to_s
          "Some(#{wrapped.inspect})"
        end
      end

    end
  end
end
