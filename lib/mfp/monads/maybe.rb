require 'mfp/monads/base'
require 'mfp/monads/maybe/mixin'
require 'mfp/monads/maybe/some'
require 'mfp/monads/maybe/none'
require 'mfp/constants'

module MFP
  module Monads

    class Maybe
      include Base

      def self.coerce(value)
        return None.instance if value.nil?
        Some.new(value)
      end

      def self.pure(value = Undefined, &block)
        Some.new(Undefined.default(value, block))
      end

      def self.to_proc
        @to_proc ||= method(:coerce).to_proc
      end

      def initialize(to_wrap)
        @wrapped = to_wrap
      end

      def to_maybe
        self
      end

      def monad
        Maybe
      end

      def bind
        self
      end

      def or
        self
      end

      def some?
        false
      end

      def none?
        false
      end

      private
      def wrapped
        @wrapped
      end
    end

  end
end
