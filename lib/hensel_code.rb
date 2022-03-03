# frozen_string_literal: true

require_relative "hensel_code/version"
require "prime"
require "openssl"

# Main classes definitions and loadings
module HenselCode
  class Error < StandardError; end
  class BadBitRangeForRandomPrime < StandardError; end
  class WrongHenselCodeInputType < StandardError; end
  class HenselCodesWithDifferentPrimes < StandardError; end
  class HenselCodesWithDifferentPrimesAndExponents < StandardError; end
  class HenselCodesWithDifferentExponents < StandardError; end
  class IncompatibleOperandTypes < StandardError; end

  autoload  :Tools,                           "hensel_code/tools"
  autoload  :TFPEVerifier,                    "hensel_code/tfpe_verifier"
  autoload  :TruncatedFinitePadicExpansion,   "hensel_code/truncated_finite_padic_expansion"

  # aliases for classes with long names
  TFPE = TruncatedFinitePadicExpansion
  HCWDPAE = HenselCodesWithDifferentPrimesAndExponents
end
