require 'quasi_functional/result/success'
require 'quasi_functional/result/failure'

module QuasiFunctional
  module Result

    module DSL
      def Success(value)
        Success.new(value)
      end

      def Failure(error)
        Failure.new(error)
      end
    end

  end
end
