require 'mfp/result/success'
require 'mfp/result/failure'

module MFP
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
