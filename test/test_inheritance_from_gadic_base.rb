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
end
