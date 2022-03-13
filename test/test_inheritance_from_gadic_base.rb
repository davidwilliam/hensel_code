# frozen_string_literal: true

require "test_helper"

class TestInheritanceFromGAdicBase < Minitest::Test
  include HenselCode::Tools

  def setup
    @exponent = 3
    @primes = random_distinct_numbers("prime", @exponent, 9)
    @g = @primes.inject(:*)
    @n = Integer.sqrt(((@g**@exponent) - 1) / 2)
    @rationals = (1..100).map { |i| Rational(i, i + 1) }
    @rat1, @rat2 = Array.new(2) { @rationals.sample }
  end

  def test_numerator_denominator
    assert_equal @rat1.numerator, @rat1.numerator
    assert_equal @rat1.denominator, @rat1.denominator
  end

  def test_to_r
    h1 = HenselCode::TruncatedFiniteGadicExpansion.new @primes, @exponent, @rat1

    assert_equal @rat1, h1.to_r
  end

  # def test_basic_arithmetic_finite_segment_padic_expansion
  #   h1 = HenselCode::FinitePadicExpansion.new @prime, 7, @rat1
  #   h2 = HenselCode::FinitePadicExpansion.new @prime, 7, @rat2

  #   ["+"].each do |op|
  #     assert_equal @rat1.send(op, @rat2), h1.send(op, h2).to_r
  #   end
  # end

  # def test_basic_arithmetic_truncated_finite_segment_padic_expansion
  #   h1 = HenselCode::TruncatedFinitePadicExpansion.new @prime, 7, @rat1
  #   h2 = HenselCode::TruncatedFinitePadicExpansion.new @prime, 7, @rat2

  #   ["+", "-", "*", "/"].each do |op|
  #     assert_equal @rat1.send(op, @rat2), h1.send(op, h2).to_r
  #   end
  # end

  # def test_replace_rational_finite_segment_padic_expansion
  #   h1 = HenselCode::FinitePadicExpansion.new @prime, @exponent, @rat1
  #   @prime2 = random_prime(17)

  #   assert_equal @rat1 + 1, h1.replace_rational(@rat1 + 1).to_r
  # end

  # def test_replace_prime_finite_segment_padic_expansion
  #   h1 = HenselCode::FinitePadicExpansion.new @prime, @exponent, @rat1
  #   @prime2 = random_prime(17)

  #   assert_equal @prime2, h1.replace_prime(@prime2).prime
  # end

  # def test_replace_exponent_finite_segment_padic_expansion
  #   h1 = HenselCode::FinitePadicExpansion.new @prime, @exponent, @rat1
  #   @prime2 = random_prime(17)

  #   assert_equal @exponent + 1, h1.replace_exponent(@exponent + 1).exponent
  # end

  # def test_replace_hensel_code_finite_segment_padic_expansion
  #   h1 = HenselCode::FinitePadicExpansion.new @prime, @exponent, @rat1
  #   @prime2 = random_prime(17)
  #   random_hensel_code = Array.new(@exponent + 1) { rand(0..h1.modulus - 1) }

  #   assert_equal @exponent + 1, h1.replace_exponent(@exponent + 1).exponent
  #   assert_equal random_hensel_code, h1.replace_hensel_code(random_hensel_code).hensel_code
  # end
end
