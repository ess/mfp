require 'singleton'
require 'mfp/monads/lefty'

module MFP
  module Monads
    class Maybe

      class None < Maybe
        include Singleton
        include Lefty

        def initialize(to_wrap = nil)
          freeze
        end

        def eql?(other)
          other.is_a(None)
        end

        def to_s
          'None'
        end
      end

    end
  end
end
