require 'mfp/result/base'

module MFP
  module Result

    class Failure
      include Base

      attr_reader :error

      def initialize(error)
        @error = error
        freeze
      end

      def failure?
        true
      end

      def or_else
        yield error
      end

      def on_failure
        yield error
        self
      end
    end

  end
end
