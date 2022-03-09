# frozen_string_literal: true

require "test_helper"

class TestPolynomial < Minitest::Test
  include HenselCode::Tools

  def setup
    @prime = 257
    @exponent = 3
    @exponent2 = @exponent + 1
    @n = Integer.sqrt(((@prime**@exponent) - 1) / 2)
    x = 0
    y = 1
    @rationals = (1..100).map{|i| Rational(x+i, y+i) }
    @rat1, @rat2 = Array.new(2) { @rationals.sample }
  end

  def test_initialize
    coefficients = random_distinct_integers(@exponent, 8)
    f = HenselCode::Polynomial.new @prime, coefficients

    assert_equal HenselCode::Polynomial, f.class
    assert_equal @prime, f.prime
    assert f.fixed_length
    assert_equal coefficients, f.coefficients
  end

  def test_addition
    coefficients1 = random_distinct_integers(@exponent, 8)
    coefficients2 = random_distinct_integers(@exponent, 8)

    f1 = HenselCode::Polynomial.new @prime, coefficients1
    f2 = HenselCode::Polynomial.new @prime, coefficients2

    expected_sum = [coefficients1, coefficients2].transpose.map{|x| x.reduce(:+) % @prime }
    
    assert_equal expected_sum, (f1 + f2).coefficients
  end

  def test_subtraction
    coefficients1 = random_distinct_integers(@exponent, 8)
    coefficients2 = random_distinct_integers(@exponent, 8)

    f1 = HenselCode::Polynomial.new @prime, coefficients1
    f2 = HenselCode::Polynomial.new @prime, coefficients2

    expected_subtraction = [coefficients1, coefficients2].transpose.map{|x| x.reduce(:-) % @prime }
    
    assert_equal expected_subtraction, (f1 - f2).coefficients
  end

  def test_multiplication
    coefficients1 = random_distinct_integers(@exponent, 8)
    coefficients2 = random_distinct_integers(@exponent, 8)

    h1 = HenselCode::FinitePadicExpansion.new @prime, @exponent, coefficients1
    h2 = HenselCode::FinitePadicExpansion.new @prime, @exponent, coefficients2
    h3 = h1 * h2

    f1 = HenselCode::Polynomial.new @prime, coefficients1
    f2 = HenselCode::Polynomial.new @prime, coefficients2

    assert_equal h3.hensel_code, (f1 * f2).coefficients
  end

  # def test_inverse
  #   coefficients1 = random_distinct_integers(@exponent, 8)
  #   coefficients2 = random_distinct_integers(@exponent, 8)

  #   h1 = HenselCode::FinitePadicExpansion.new @prime, @exponent, coefficients1
  #   h2 = HenselCode::FinitePadicExpansion.new @prime, @exponent, coefficients2
  #   h3 = h1 / h2

  #   f1 = HenselCode::Polynomial.new @prime, coefficients1
  #   f2 = HenselCode::Polynomial.new @prime, coefficients2

  #   assert_equal h3.hensel_code, (f1 / f2).coefficients
  # end
end