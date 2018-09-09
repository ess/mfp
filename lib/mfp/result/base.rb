module MFP
  module Result

    module Base
      def success?
        false
      end

      def failure?
        false
      end

      def value
        raise "not present"
      end

      def error
        raise "not present"
      end

      def and_then
        self
      end

      def or_else
        self
      end

      def on_success
        self
      end

      def on_failure
        self
      end
    end

  end
end
