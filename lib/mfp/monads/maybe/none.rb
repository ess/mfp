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
          other.is_a?(None)
        end

        def ===(other)
          None === other
        end

        def none?
          true
        end
        alias_method :failure?, :none?

        def to_s
          'None'
        end
        alias_method :inspect, :to_s

        def or(*args)
          if block_given?
            yield(*args)
          else
            args.first
          end
        end

        def or_fmap(*args, &block)
          Maybe.coerce(self.or(*args, &block))
        end

        def some?
          false
        end
        alias_method :success?, :some?

        def self.new(*)
          @@instance
        end
      end

    end
  end
end
