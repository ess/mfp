require 'singleton'
require 'mfp/monads/lefty'

module MFP
  module Monads
    class Maybe

      class None < Maybe
        include Lefty

        def initialize(to_wrap = nil)
          freeze
        end

        @@instance = None.new

        def self.instance
          return @@instance
        end

        def eql?(other)
          other.is_a(None)
        end

        def ===(other)
          None === other
        end

        def none?
          true
        end

        def to_s
          'None'
        end

        def self.new(*)
          @@instance
        end
      end

    end
  end
end
