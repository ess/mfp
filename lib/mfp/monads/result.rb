require 'mfp/monads/base'
require 'mfp/monads/result/mixin'
require 'mfp/monads/result/success'
require 'mfp/monads/result/failure'
require 'mfp/constants'

module MFP
  module Monads

    class Result
      include Base

      def self.pure(value = Undefined, &block)
        Success.new(Undefined.default(value, block))
      end

      def initialize(to_wrap)
        @wrapped = to_wrap
      end

      def to_result
        self
      end

      def monad
        Result
      end

      def failure?
        false
      end

      def success?
        false
      end

      private
      def wrapped
        @wrapped
      end
    end

  end
end
