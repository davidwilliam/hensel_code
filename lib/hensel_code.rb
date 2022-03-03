# frozen_string_literal: true

require_relative "hensel_code/version"
require 'prime'
require 'openssl'

module HenselCode
  class Error < StandardError; end
  class BadBitRangeForRandomPrime < StandardError; end
  class WrongHenselCodeInputType < StandardError; end
  class HenselCodesWithDifferentPrimes < StandardError; end
  class HenselCodesWithDifferentPrimesAndExponents < StandardError; end
  class HenselCodesWithDifferentExponents < StandardError; end
  class IncompatibleOperandTypes < StandardError; end
  
  autoload  :Tools,                           'hensel_code/tools'
  autoload  :TruncatedFinitePadicExpansion,   'hensel_code/truncated_finite_padic_expansion'
end
