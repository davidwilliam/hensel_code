# frozen_string_literal: true

require "test_helper"

class TestTFPEArithmetic < Minitest::Test
  include HenselCode::Tools

  def setup
    @prime = random_prime(8)
    @exponent = rand(2..6)
    @exponent2 = @exponent + 1
    @n = Integer.sqrt(((@prime**@exponent) - 1) / 2)
    @rationals = (0..@prime / 2).map { |h| HenselCode::TruncatedFinitePadicExpansion.new(@prime, @exponent, h).to_r }
    @rat1, @rat2 = Array.new(2) { @rationals.sample }
  end

  def test_valid_operation_properties
    rat1, rat2 = Array.new(2) { @rationals.sample }
    h1 = HenselCode::TruncatedFinitePadicExpansion.new @prime, @exponent, rat1
    h2 = HenselCode::TruncatedFinitePadicExpansion.new @prime, @exponent, rat2

    ["+", "-", "*", "/"].each do |operation|
      h3 = h1.send(operation, h2)

      assert_equal HenselCode::TruncatedFinitePadicExpansion, h3.class
      assert_equal @prime, h3.prime
      assert_equal @exponent, h3.exponent
    end
  end

  def test_valid_operation_evaluation
    rat1, rat2 = Array.new(2) { @rationals.sample }
    h1 = HenselCode::TruncatedFinitePadicExpansion.new @prime, @exponent, rat1
    h2 = HenselCode::TruncatedFinitePadicExpansion.new @prime, @exponent, rat2

    ["+", "-", "*", "/"].each do |operation|
      h3 = h1.send(operation, h2)

      assert_equal rat1.send(operation, rat2), h3.to_r
    end
  end

  def test_operation_of_hensel_codes_with_different_primes_same_exponent
    prime1, prime2 = random_distinct_primes(2, 16)
    exponent = 2
    rat1, rat2 = Array.new(2) { @rationals.sample }
    h1 = HenselCode::TruncatedFinitePadicExpansion.new prime1, exponent, rat1
    h2 = HenselCode::TruncatedFinitePadicExpansion.new prime2, exponent, rat2
    expected_error_message = "#{h1} has prime #{h1.prime} while #{h2} has prime #{h2.prime}"

    ["+", "-", "*", "/"].each do |operation|
      assert_raises(HenselCode::HenselCodesWithDifferentPrimes, expected_error_message) { h1.send(operation, h2) }
    end
  end

  def test_operation_of_hensel_codes_with_same_primes_different_exponents
    prime = random_prime(16)
    exponent1 = 2
    exponent2 = 3
    rat1, rat2 = Array.new(2) { @rationals.sample }
    h1 = HenselCode::TruncatedFinitePadicExpansion.new prime, exponent1, rat1
    h2 = HenselCode::TruncatedFinitePadicExpansion.new prime, exponent2, rat2
    expected_error_message = "#{h1} has exponent #{h1.prime} while #{h2} has prime #{h2.prime}"

    ["+", "-", "*", "/"].each do |operation|
      assert_raises(HenselCode::HenselCodesWithDifferentExponents, expected_error_message) { h1.send(operation, h2) }
    end
  end

  def test_operation_of_hensel_codes_with_different_primes_different_exponents
    prime1, prime2 = random_distinct_primes(2, 9)
    h1, h2 = [[prime1, @exponent, @rat1], [prime2, @exponent2, @rat2]].map do |er|
      HenselCode::TFPE.new er[0], er[1], er[2]
    end
    expected_error_message = "#{h1} has prime #{h1.prime} and exponent #{h1.exponent}"
    expected_error_message += " while #{h2} has prime #{h2.prime} and exponent #{h2.exponent}"
    ["+", "-", "*", "/"].each do |operation|
      assert_raises(HenselCode::HCWDPAE, expected_error_message) { h1.send(operation, h2) }
    end
  end
end
