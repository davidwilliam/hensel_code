# frozen_string_literal: true

require "test_helper"

class TestInheritanceFromPAdicBase < Minitest::Test
  include HenselCode::Tools

  def setup
    @prime = random_prime(16)
    @exponent = 3
    @exponent2 = @exponent + 1
    @n = Integer.sqrt(((@prime**@exponent) - 1) / 2)
    x = 0
    y = 1
    @rationals = (1..100).map{|i| Rational(x+i, y+i) }
    @rat1, @rat2 = Array.new(2) { @rationals.sample }
  end

  def test_numerator_denominator
    assert_equal @rat1.numerator, @rat1.numerator
    assert_equal @rat1.denominator, @rat1.denominator
  end

  def test_to_r
    h1 = HenselCode::FinitePadicExpansion.new @prime, @exponent, @rat1
    h2 = HenselCode::TruncatedFinitePadicExpansion.new @prime, @exponent, @rat2

    assert_equal @rat1, h1.to_r
    assert_equal @rat2, h2.to_r
  end

  def test_basic_arithmetic_finite_segment_padic_expansion
    h1 = HenselCode::FinitePadicExpansion.new @prime, @exponent, @rat1
    h2 = HenselCode::FinitePadicExpansion.new @prime, @exponent, @rat2

    assert_equal @rat1 + @rat2, (h1 + h2).to_r
    assert_equal @rat1 - @rat2, (h1 - h2).to_r
    assert_equal @rat1 * @rat2, (h1 * h2).to_r
    assert_equal @rat1 / @rat2, (h1 / h2).to_r
  end

  def test_basic_arithmetic_truncated_finite_segment_padic_expansion
    h1 = HenselCode::TruncatedFinitePadicExpansion.new @prime, @exponent, @rat1
    h2 = HenselCode::TruncatedFinitePadicExpansion.new @prime, @exponent, @rat2

    assert_equal @rat1 + @rat2, (h1 + h2).to_r
    assert_equal @rat1 - @rat2, (h1 - h2).to_r
    assert_equal @rat1 * @rat2, (h1 * h2).to_r
    assert_equal @rat1 / @rat2, (h1 / h2).to_r
  end

  def test_replace_attributes_finite_segment_padic_expansion
    h1 = HenselCode::FinitePadicExpansion.new @prime, @exponent, @rat1
    @prime2 = random_prime(17)
    random_hensel_code = Array.new(@exponent + 1){ rand(0..h1.modulus - 1) }

    assert_equal @rat1 + 1, h1.replace_rational(@rat1 + 1).to_r
    assert_equal @prime2, h1.replace_prime(@prime2).prime
    assert_equal @exponent + 1, h1.replace_exponent(@exponent + 1).exponent
    assert_equal random_hensel_code, h1.replace_hensel_code(random_hensel_code).hensel_code
  end
end