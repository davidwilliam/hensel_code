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
  class NonInitializableClass < StandardError; end

  autoload  :Tools, "hensel_code/tools"
  autoload  :PAdicBase, "hensel_code/padic_base"
  autoload  :GAdicBase, "hensel_code/gadic_base"
  autoload  :Polynomial, "hensel_code/polynomial"
  autoload  :PAdicVerifier, "hensel_code/padic_verifier"
  autoload  :GAdicVerifier, "hensel_code/gadic_verifier"
  autoload  :ModularArithmetic, "hensel_code/modular_arithmetic"
  autoload  :FinitePadicExpansion, "hensel_code/finite_padic_expansion"
  autoload  :FiniteGadicExpansion, "hensel_code/finite_gadic_expansion"
  autoload  :TruncatedFinitePadicExpansion, "hensel_code/truncated_finite_padic_expansion"
  autoload  :TruncatedFiniteGadicExpansion, "hensel_code/truncated_finite_gadic_expansion"

  # aliases for classes with long names
  TFPE = TruncatedFinitePadicExpansion
  FPE = TruncatedFinitePadicExpansion
  HCWDPAE = HenselCodesWithDifferentPrimesAndExponents
  WHIT = WrongHenselCodeInputType
end
