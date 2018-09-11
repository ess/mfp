module MFP
  module Monads

    Unit = Object.new
    Unit.instance_eval do
      def to_s
        'Unit'
      end

      def inspect
        'Unit'
      end
    end
  end
end
