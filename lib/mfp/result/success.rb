module MFP
  class Result

    class Success < Result
      def success?
        true
      end

      def bind
        yield value
      end

      def on_success
        yield value
        self
      end

      def value
        wrapped
      end
    end

  end
end
