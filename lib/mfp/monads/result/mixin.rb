require 'mfp/monads/result/success'
require 'mfp/monads/result/failure'

module MFP
  module Monads
    class Result

      module Mixin
        def Success(value)
          Success.new(value)
        end

        def Failure(error)
          Failure.new(error)
        end
      end

    end
  end
end
