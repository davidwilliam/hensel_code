# frozen_string_literal: true

require "test_helper"

class TestPolynomial < Minitest::Test
  include HenselCode::Tools
  include HenselCode::ModularArithmetic

  def setup
    @prime = 257
    @exponent = 3
    @exponent2 = @exponent + 1
    @n = Integer.sqrt(((@prime**@exponent) - 1) / 2)
    x = 0
    y = 1
    @rationals = (1..100).map { |i| Rational(x + i, y + i) }
    @rat1, @rat2 = Array.new(2) { @rationals.sample }
  end

  def test_addition
    coefficients1 = random_distinct_numbers("integer", @exponent, 8)
    coefficients2 = random_distinct_numbers("integer", @exponent, 8)

    f1 = HenselCode::Polynomial.new @prime, coefficients1
    f2 = HenselCode::Polynomial.new @prime, coefficients2

    h1 = HenselCode::FinitePadicExpansion.new @prime, @exponent, coefficients1
    h2 = HenselCode::FinitePadicExpansion.new @prime, @exponent, coefficients2

    expected_sum = HenselCode::FinitePadicExpansion.new(@prime, @exponent, (h1.to_r + h2.to_r)).hensel_code

    assert_equal expected_sum, (f1 + f2).coefficients
  end

  def test_negation
    prime = 5
    coefficients = [0, 1, 4, 0, 4, 0, 4, 0, 4]

    assert_equal [0, 4, 0, 4, 0, 4, 0, 4, 0], negation(prime, coefficients)
  end

  def test_subtraction
    prime = 5

    coefficients1 = [4, 1, 3, 1, 3, 1, 3, 1, 3]
    coefficients2 = [0, 1, 4, 0, 4, 0, 4, 0, 4]

    f1 = HenselCode::Polynomial.new prime, coefficients1
    f2 = HenselCode::Polynomial.new prime, coefficients2

    expected_subtraction = [4, 0, 4, 0, 4, 0, 4, 0, 4]

    assert_equal expected_subtraction, (f1 - f2).coefficients
  end

  def test_multiplication
    coefficients1 = [231, 202, 84]
    coefficients2 = [103, 99, 232]

    h1 = HenselCode::FinitePadicExpansion.new @prime, @exponent, coefficients1
    h2 = HenselCode::FinitePadicExpansion.new @prime, @exponent, coefficients2
    h3 = h1 * h2

    f1 = HenselCode::Polynomial.new @prime, coefficients1
    f2 = HenselCode::Polynomial.new @prime, coefficients2

    assert_equal h3.hensel_code, (f1 * f2).coefficients
  end

  def test_cauchy_product_five_coefficients
    prime = 257
    coefficients1 = [87, 171, 85, 171, 85]
    coefficients2 = [194, 192, 192, 192, 192]
    expected_coefficients = [173, 85, 171, 85, 171]

    assert_equal expected_coefficients, cauchy_product(prime, coefficients1, coefficients2)
  end

  def test_modular_multiplication
    prime = 257
    coefficients1 = [171, 85, 172]
    coefficients2 = [205, 154, 52]

    f1 = HenselCode::Polynomial.new prime, coefficients1
    f2 = HenselCode::Polynomial.new prime, coefficients2

    expected_expanded_coefficients = [103, 205, 101, 34, 70, 35]
    expected_polynomial_coefficients = [103, 205, 101]

    assert_equal expected_expanded_coefficients, f1.send(:mul, f2).coefficients
    assert_equal expected_polynomial_coefficients, (f1 * f2).coefficients
  end

  def test_inverse
    prime = 5
    r = 7
    h1 = HenselCode::FinitePadicExpansion.new prime, r, Rational(2, 3)
    h1_inv = HenselCode::FinitePadicExpansion.new prime, r, Rational(3, 2)

    f1 = HenselCode::Polynomial.new prime, h1.hensel_code
    f1_inv = HenselCode::Polynomial.new prime, h1_inv.hensel_code

    assert_equal f1_inv.coefficients, f1.inverse.coefficients
  end

  def test_division
    h1 = HenselCode::FinitePadicExpansion.new @prime, @exponent, Rational(2, 3)
    h2 = HenselCode::FinitePadicExpansion.new @prime, @exponent, Rational(1, 12)
    h1_div_h2 = HenselCode::FinitePadicExpansion.new @prime, @exponent, Rational(2, 3) / Rational(1, 12)

    f1 = HenselCode::Polynomial.new @prime, h1.hensel_code
    f2 = HenselCode::Polynomial.new @prime, h2.hensel_code

    assert_equal h1_div_h2.hensel_code, (f1 / f2).coefficients
  end
end
