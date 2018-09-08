require 'mfp/version'
require 'mfp/result'
require 'mfp/railway'

# FP-style (but non-FP) utilities for Ruby
module MFP
  def self.Result
    self::Result::DSL
  end

  def self.Railway
    self::Railway
  end
end
