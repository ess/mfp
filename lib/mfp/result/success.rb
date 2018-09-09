require 'mfp/result/base'

module MFP
  module Result

    class Success
      include Base

      attr_reader :value

      def initialize(value)
        @value = value

      end

      def success?
        true
      end

      def and_then
        yield value
      end

      def on_success
        yield value
        self
      end
    end

  end
end
