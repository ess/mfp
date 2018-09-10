require 'mfp/result/mixin'
require 'mfp/result/success'
require 'mfp/result/failure'

module MFP

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
