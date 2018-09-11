require 'mfp/monads/righty'

module MFP
  module Monads
    class Result

      class Success < Result
        include Righty

        def success?
          true
        end

        def fmap(*args, &block)
          Success.new(bind(*args, &block))
        end

        def to_s
          "Success(#{wrapped.inspect})"
        end

        alias_method :success, :value!
        alias_method :inspect, :to_s
      end

    end
  end
end
