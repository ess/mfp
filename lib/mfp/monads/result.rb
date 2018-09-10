require 'mfp/monads/result/mixin'
require 'mfp/monads/result/success'
require 'mfp/monads/result/failure'

module MFP
  module Monads

    class Result
      def initialize(to_wrap)
        @wrapped = to_wrap
      end

      def to_result
        self
      end

      def to_monad
        self
      end

      def monad
        Result
      end

      def bind
        self
      end

      def or
        self
      end

      def success?
        false
      end

      def failure?
        false
      end

      private
      def wrapped
        @wrapped
      end
    end

  end
end
