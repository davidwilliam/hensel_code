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

  def test_initialize
    coefficients = random_distinct_numbers("integer", @exponent, 8)
    f = HenselCode::Polynomial.new @prime, coefficients

    assert_equal HenselCode::Polynomial, f.class
    assert_equal @prime, f.prime
    assert f.fixed_length
    assert_equal coefficients, f.coefficients
  end

  def test_addition
    coefficients1 = random_distinct_numbers("integer", @exponent, 8)
    coefficients2 = random_distinct_numbers("integer", @exponent, 8)

    f1 = HenselCode::Polynomial.new @prime, coefficients1
    f2 = HenselCode::Polynomial.new @prime, coefficients2

    expected_sum = [coefficients1, coefficients2].transpose.map { |x| x.reduce(:+) % @prime }

    assert_equal expected_sum, (f1 + f2).coefficients
  end

  def test_subtraction
    coefficients1 = random_distinct_numbers("integer", @exponent, 8)
    coefficients2 = random_distinct_numbers("integer", @exponent, 8)

    f1 = HenselCode::Polynomial.new @prime, coefficients1
    f2 = HenselCode::Polynomial.new @prime, coefficients2

    expected_subtraction = [coefficients1, coefficients2].transpose.map { |x| x.reduce(:-) % @prime }

    assert_equal expected_subtraction, (f1 - f2).coefficients
  end

  def test_multiplication
    coefficients1 = random_distinct_numbers("integer", @exponent, 8)
    coefficients2 = random_distinct_numbers("integer", @exponent, 8)

    h1 = HenselCode::FinitePadicExpansion.new @prime, @exponent, coefficients1
    h2 = HenselCode::FinitePadicExpansion.new @prime, @exponent, coefficients2
    h3 = h1 * h2

    f1 = HenselCode::Polynomial.new @prime, coefficients1
    f2 = HenselCode::Polynomial.new @prime, coefficients2

    assert_equal h3.hensel_code, (f1 * f2).coefficients
  end

  def test_cauchy_product_three_coefficients
    prime = 257
    coefficients1 = [172, 85, 171]
    coefficients2 = [52, 154, 205]

    assert_equal [206, 102, 51], cauchy_product(prime, coefficients1, coefficients2)
  end

  def test_cauchy_product_five_coefficients
    prime = 257
    coefficients1 = [87, 171, 85, 171, 85]
    coefficients2 = [194, 192, 192, 192, 192]
    expected_coefficients = [173, 85, 171, 85, 171]

    assert_equal expected_coefficients, cauchy_product(prime, coefficients1, coefficients2)
  end

  def test_polynomial_multiplication_inverse
    prime = 11
    coefficients1 = [8, 3, 7]
    coefficients2 = [7, 5, 5]

    f1 = HenselCode::Polynomial.new prime, coefficients1
    f1_inv = HenselCode::Polynomial.new prime, coefficients2

    assert_equal [1, 0, 0], (f1 * f1_inv).coefficients
  end

  def test_modular_multiplication
    prime = 257
    coefficients1 = [171, 85, 172]
    coefficients2 = [205, 154, 52]

    f1 = HenselCode::Polynomial.new prime, coefficients1
    f2 = HenselCode::Polynomial.new prime, coefficients2

    expected_expanded_coefficients = [103, 205, 101, 34, 70, 35]
    expected_polynomial_coefficients = [103, 205, 101]

    assert_equal expected_expanded_coefficients, f1.mul(f2).coefficients
    assert_equal expected_polynomial_coefficients, (f1 * f2).coefficients
  end

  def test_division
    prime = 257
    coefficients1 = [172, 85, 171]
    coefficients2 = [205, 154, 52]
    # [56, 170, 253]

    f1 = HenselCode::Polynomial.new prime, coefficients1
    f2 = HenselCode::Polynomial.new prime, coefficients2

    puts "f1.div(f2) = #{f1.div(f2).coefficients}"
  end
end
