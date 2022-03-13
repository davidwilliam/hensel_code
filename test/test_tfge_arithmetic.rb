# frozen_string_literal: true

require "test_helper"

class TestTFGEArithmetic < Minitest::Test
  include HenselCode::Tools

  def setup
    @exponent = 3
    @primes = [257, 263, 269]
    @g = @primes.inject(:*)
    @n = Integer.sqrt(((@g**@exponent) - 1) / 2)
    @rationals = (1..100).map { |i| Rational(i, i + 1) }
    @rat1, @rat2 = Array.new(2) { @rationals.sample }
  end

  def test_valid_operation_properties
    rat1, rat2 = Array.new(2) { @rationals.sample }
    h1 = HenselCode::TruncatedFiniteGadicExpansion.new @primes, @exponent, rat1
    h2 = HenselCode::TruncatedFiniteGadicExpansion.new @primes, @exponent, rat2

    ["+", "-", "*", "/"].each do |operation|
      h3 = h1.send(operation, h2)

      assert_equal HenselCode::TruncatedFiniteGadicExpansion, h3.class
      assert_equal @primes, h3.primes
      assert_equal @exponent, h3.exponent
    end
  end

  def test_valid_operation_evaluation
    rat1, rat2 = Array.new(2) { @rationals.sample }
    h1 = HenselCode::TruncatedFiniteGadicExpansion.new @primes, @exponent, rat1
    h2 = HenselCode::TruncatedFiniteGadicExpansion.new @primes, @exponent, rat2

    ["+", "-", "*", "/"].each do |operation|
      h3 = h1.send(operation, h2)

      assert_equal rat1.send(operation, rat2), h3.to_r
    end
  end

  def test_operation_of_hensel_codes_with_different_primes_same_exponent
    primes1 = [313, 317, 331]
    primes2 = [367, 373, 379]
    rat1 = @rationals.sample
    rat2 = @rationals.sample
    h1 = HenselCode::TruncatedFiniteGadicExpansion.new primes1, @exponent, rat1
    h2 = HenselCode::TruncatedFiniteGadicExpansion.new primes2, @exponent, rat2
    expected_error_message = "#{h1} has primes #{h1.primes} while #{h2} has prime #{h2.primes}"

    ["+", "-", "*", "/"].each do |operation|
      assert_raises(HenselCode::HenselCodesWithDifferentPrimes, expected_error_message) { h1.send(operation, h2) }
    end
  end

  def test_operation_of_hensel_codes_with_same_primes_different_exponents
    exponent1 = 2
    exponent2 = 3
    rat1 = @rationals.sample
    rat2 = @rationals.sample
    h1 = HenselCode::TruncatedFiniteGadicExpansion.new @primes, exponent1, rat1
    h2 = HenselCode::TruncatedFiniteGadicExpansion.new @primes, exponent2, rat2
    expected_error_message = "#{h1} has exponent #{h1.exponent} while #{h2} has exponent #{h2.exponent}"

    ["+", "-", "*", "/"].each do |operation|
      assert_raises(HenselCode::HenselCodesWithDifferentExponents, expected_error_message) { h1.send(operation, h2) }
    end
  end

  def test_operation_of_hensel_codes_with_different_primes_different_exponents
    primes1 = [313, 317, 331]
    primes2 = [367, 373, 379]
    rat1, rat2 = Array.new(2) { @rationals.sample }
    h1 = HenselCode::TruncatedFiniteGadicExpansion.new primes1, @exponent, rat1
    h2 = HenselCode::TruncatedFiniteGadicExpansion.new primes2, @exponent + 1, rat2
    expected_error_message = "#{h1} has primes #{h1.primes} and exponent #{h1.exponent}"
    expected_error_message += " while #{h2} has primes #{h2.primes} and exponent #{h2.exponent}"
    ["+", "-", "*", "/"].each do |operation|
      assert_raises(HenselCode::HCWDPAE, expected_error_message) { h1.send(operation, h2) }
    end
  end
end
