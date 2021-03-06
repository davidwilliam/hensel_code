# frozen_string_literal: true

require "test_helper"

class TestTools < Minitest::Test
  include HenselCode::Tools

  def test_generate_random_integer
    assert_equal Integer, random_integer(8).class
    assert_equal 15, random_integer(15).bit_length
  end

  def test_generate_random_rational
    rational = random_rational(9)
    assert_equal Rational, rational.class
    assert_equal 9, rational.numerator.bit_length
    assert_equal 9, rational.denominator.bit_length
  end

  def test_generate_random_prime
    expected_error_message = "The bit length must be greater than or equal to 2"

    assert_equal Integer, random_prime(9).class
    assert_equal 14, random_prime(14).bit_length
    assert_raises(HenselCode::BadBitRangeForRandomPrime, expected_error_message) { random_prime(1).bit_length }
  end

  def test_random_distinct_integers
    20.times do
      integers = random_distinct_numbers("integer", 20, 8)
      assert_equal integers, integers.uniq
    end
  end

  def test_eea_core
    assert_equal [1, 1, 3, 0, -22], eea_core(23, 22)
    assert_equal [9, 1, 3, 0, -8], eea_core(9, 72)
    assert_equal [2, -1, 4, 0, 20], eea_core(38, 40)
    assert_equal [1, 14, 7, 0, -257], eea_core(202, 257)
  end

  def test_extended_gcd
    assert_equal [1, 1], extended_gcd(23, 22)
    assert_equal [1, -5], extended_gcd(18, -13)
    assert_equal [1, -10], extended_gcd(-19, -21)
    assert_equal [1, 1], extended_gcd(-12, 13)
    assert_equal [9, 1], extended_gcd(9, 72)
    assert_equal [2, -1], extended_gcd(38, 40)
  end

  def test_mod_inverse
    expected_error_message = "4 has no inverse modulo 256"

    assert_equal 86, mod_inverse(3, 257)
    assert_equal 185, mod_inverse(-25, 257)
    assert_raises(ZeroDivisionError, expected_error_message) { mod_inverse(4, 256) }
  end

  def test_crt
    moduli_one = [231, 251, 257]
    remainders_one = [199, 222, 121]

    moduli_two = [367, 331, 389, 433, 479, 449]
    remainders_two = [188, 234, 27, 214, 205, 183]

    assert_equal 9_024_676, crt(moduli_one, remainders_one)
    assert_equal 800_155_308_225_567, crt(moduli_two, remainders_two)
  end
end
