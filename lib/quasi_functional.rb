require 'quasi_functional/version'
require 'quasi_functional/result'
require 'quasi_functional/railway'

# FP-style (but non-FP) utilities for Ruby
module QuasiFunctional
  def self.Result
    self::Result::DSL
  end

  def self.Railway
    self::Railway
  end
end
