require "test_helper"

class TestTruncatedFinitePadicExpansion < Minitest::Test
  include HenselCode::Tools

  def setup
    @prime = random_prime(8)
    @exponent = rand(2..6)
    @n = Integer.sqrt((@prime**@exponent - 1)/2)
    @rational = random_rational(@n.bit_length - 1)
    @rationals = (0..@prime/2).map{|h| HenselCode::TruncatedFinitePadicExpansion.new(@prime,@exponent,h).to_r}
    @h = HenselCode::TruncatedFinitePadicExpansion.new @prime, @exponent, @rational
  end
  
  def test_create_hensel_code
    assert_equal HenselCode::TruncatedFinitePadicExpansion, @h.class
    assert_equal @prime, @h.prime
    assert_equal @exponent, @h.exponent
    assert_equal @n, @h.n
    assert_equal Integer, @h.hensel_code.class
    assert_equal Integer, @h.to_i.class
  end

  def test_encode_decode
    assert_equal @rational, @h.rational
    assert_equal @rational, @h.to_r
  end

  def test_to_s
    assert_equal @h.hensel_code.to_s, @h.to_s
  end

  def test_replace_exponent
    prime = 257
    exponent = 3
    rational = @rationals.sample
    h = HenselCode::TruncatedFinitePadicExpansion.new prime, exponent, rational

    assert_equal rational, h.to_r
    assert_equal rational, h.replace_exponent(exponent+2).to_r
  end

  def test_replace_rational
    prime = 257
    exponent = 3
    rational1 = @rationals.sample
    rational2 = @rationals.sample
    h = HenselCode::TruncatedFinitePadicExpansion.new prime, exponent, rational1

    assert_equal rational1, h.to_r
    assert_equal rational2, h.replace_rational(rational2).to_r
  end

  def test_replace_prime
    prime1, prime2 = random_distinct_primes(2, 9)
    exponent = 3
    rational = @rationals.sample
    h = HenselCode::TruncatedFinitePadicExpansion.new prime1, exponent, rational

    assert_equal prime1, h.prime
    assert_equal rational, h.to_r
    assert_equal prime2, h.replace_prime(prime2).prime
    assert_equal rational, h.to_r
  end

  def test_valid_sum
    prime = random_prime(16)
    exponent = 2
    rational1 = @rationals.sample
    rational2 = @rationals.sample
    h1 = HenselCode::TruncatedFinitePadicExpansion.new prime, exponent, rational1
    h2 = HenselCode::TruncatedFinitePadicExpansion.new prime, exponent, rational2
    h3 = h1 + h2
    expected_hensel_code = (h1.hensel_code + h2.hensel_code) % h1.modulus

    assert_equal HenselCode::TruncatedFinitePadicExpansion, h3.class
    assert_equal expected_hensel_code, h3.hensel_code
    assert_equal prime, h3.prime
    assert_equal exponent, h3.exponent
    assert_equal rational1 + rational2, h3.to_r
  end

  def test_sum_of_hensel_codes_with_different_primes_same_exponent
    prime1, prime2 = random_distinct_primes(2, 16)
    exponent = 2
    rational1 = @rationals.sample
    rational2 = @rationals.sample
    h1 = HenselCode::TruncatedFinitePadicExpansion.new prime1, exponent, rational1
    h2 = HenselCode::TruncatedFinitePadicExpansion.new prime2, exponent, rational2
    expected_error_message = "#{h1} has prime #{h1.prime} while #{h2} has prime #{h2.prime}"

    assert_raises(HenselCode::HenselCodesWithDifferentPrimes, expected_error_message) { h1 + h2 }
  end

  def test_sum_of_hensel_codes_with_same_primes_different_exponents
    prime = random_prime(16)
    exponent1 = 2
    exponent2 = 3
    rational1 = @rationals.sample
    rational2 = @rationals.sample
    h1 = HenselCode::TruncatedFinitePadicExpansion.new prime, exponent1, rational1
    h2 = HenselCode::TruncatedFinitePadicExpansion.new prime, exponent2, rational2
    expected_error_message = "#{h1} has exponent #{h1.prime} while #{h2} has prime #{h2.prime}"

    assert_raises(HenselCode::HenselCodesWithDifferentExponents, expected_error_message) { h1 + h2 }
  end

  def test_sum_of_hensel_codes_with_different_primes_different_exponents
    prime1, prime2 = random_distinct_primes(2, 9)
    exponent1 = 2
    exponent2 = 3
    rational1 = @rationals.sample
    rational2 = @rationals.sample
    h1 = HenselCode::TruncatedFinitePadicExpansion.new prime1, exponent1, rational1
    h2 = HenselCode::TruncatedFinitePadicExpansion.new prime2, exponent2, rational2
    expected_error_message =  "#{h1} has prime #{h1.prime} and exponent #{h1.exponent} while #{h2} has prime #{h2.prime} and exponent #{h2.exponent}"

    assert_raises(HenselCode::HenselCodesWithDifferentPrimesAndExponents, expected_error_message) { h1 + h2 }
  end

  def test_sum_of_hensel_code_and_some_other_object
    prime = random_prime(16)
    exponent1 = 2
    rational = @rationals.sample
    h1 = HenselCode::TruncatedFinitePadicExpansion.new prime, exponent1, rational
    h2 = h1.hensel_code + 1
    expected_error_message = "#{h1} is a #{h1.class} while #{h2} is a #{h2.class}"

    assert_raises(HenselCode::IncompatibleOperandTypes, expected_error_message) { h1 + h2 }
  end

  def test_valid_subtraction
    prime = random_prime(16)
    exponent = 2
    rational1 = @rationals.sample
    rational2 = @rationals.sample
    h1 = HenselCode::TruncatedFinitePadicExpansion.new prime, exponent, rational1
    h2 = HenselCode::TruncatedFinitePadicExpansion.new prime, exponent, rational2
    h3 = h1 - h2
    expected_hensel_code = (h1.hensel_code - h2.hensel_code) % h1.modulus

    assert_equal HenselCode::TruncatedFinitePadicExpansion, h3.class
    assert_equal expected_hensel_code, h3.hensel_code
    assert_equal prime, h3.prime
    assert_equal exponent, h3.exponent
    assert_equal rational1 - rational2, h3.to_r
  end

  def test_subtraction_of_hensel_codes_with_different_primes_same_exponent
    prime1, prime2 = random_distinct_primes(2, 16)
    exponent = 2
    rational1 = @rationals.sample
    rational2 = @rationals.sample
    h1 = HenselCode::TruncatedFinitePadicExpansion.new prime1, exponent, rational1
    h2 = HenselCode::TruncatedFinitePadicExpansion.new prime2, exponent, rational2
    expected_error_message = "#{h1} has prime #{h1.prime} while #{h2} has prime #{h2.prime}"

    assert_raises(HenselCode::HenselCodesWithDifferentPrimes, expected_error_message) { h1 - h2 }
  end

  def test_subtraction_of_hensel_codes_with_same_primes_different_exponents
    prime = random_prime(16)
    exponent1 = 2
    exponent2 = 3
    rational1 = @rationals.sample
    rational2 = @rationals.sample
    h1 = HenselCode::TruncatedFinitePadicExpansion.new prime, exponent1, rational1
    h2 = HenselCode::TruncatedFinitePadicExpansion.new prime, exponent2, rational2
    expected_error_message = "#{h1} has exponent #{h1.prime} while #{h2} has prime #{h2.prime}"

    assert_raises(HenselCode::HenselCodesWithDifferentExponents, expected_error_message) { h1 - h2 }
  end

  def test_subtraction_of_hensel_codes_with_different_primes_different_exponents
    prime1, prime2 = random_distinct_primes(2, 9)
    exponent1 = 2
    exponent2 = 3
    rational1 = @rationals.sample
    rational2 = @rationals.sample
    h1 = HenselCode::TruncatedFinitePadicExpansion.new prime1, exponent1, rational1
    h2 = HenselCode::TruncatedFinitePadicExpansion.new prime2, exponent2, rational2
    expected_error_message =  "#{h1} has prime #{h1.prime} and exponent #{h1.exponent} while #{h2} has prime #{h2.prime} and exponent #{h2.exponent}"

    assert_raises(HenselCode::HenselCodesWithDifferentPrimesAndExponents, expected_error_message) { h1 - h2 }
  end

  def test_subtraction_of_hensel_code_and_some_other_object
    prime = random_prime(16)
    exponent1 = 2
    rational = @rationals.sample
    h1 = HenselCode::TruncatedFinitePadicExpansion.new prime, exponent1, rational
    h2 = h1.hensel_code + 1
    expected_error_message = "#{h1} is a #{h1.class} while #{h2} is a #{h2.class}"

    assert_raises(HenselCode::IncompatibleOperandTypes, expected_error_message) { h1 - h2 }
  end

  def test_valid_multiplication
    prime = random_prime(16)
    exponent = 2
    rational1 = @rationals.sample
    rational2 = @rationals.sample
    h1 = HenselCode::TruncatedFinitePadicExpansion.new prime, exponent, rational1
    h2 = HenselCode::TruncatedFinitePadicExpansion.new prime, exponent, rational2
    h3 = h1 * h2
    expected_hensel_code = (h1.hensel_code * h2.hensel_code) % h1.modulus

    assert_equal HenselCode::TruncatedFinitePadicExpansion, h3.class
    assert_equal expected_hensel_code, h3.hensel_code
    assert_equal prime, h3.prime
    assert_equal exponent, h3.exponent
    assert_equal rational1 * rational2, h3.to_r
  end

  def test_multiplication_of_hensel_codes_with_different_primes_same_exponent
    prime1, prime2 = random_distinct_primes(2, 16)
    exponent = 2
    rational1 = @rationals.sample
    rational2 = @rationals.sample
    h1 = HenselCode::TruncatedFinitePadicExpansion.new prime1, exponent, rational1
    h2 = HenselCode::TruncatedFinitePadicExpansion.new prime2, exponent, rational2
    expected_error_message = "#{h1} has prime #{h1.prime} while #{h2} has prime #{h2.prime}"

    assert_raises(HenselCode::HenselCodesWithDifferentPrimes, expected_error_message) { h1 * h2 }
  end

  def test_multiplication_of_hensel_codes_with_same_primes_different_exponents
    prime = random_prime(16)
    exponent1 = 2
    exponent2 = 3
    rational1 = @rationals.sample
    rational2 = @rationals.sample
    h1 = HenselCode::TruncatedFinitePadicExpansion.new prime, exponent1, rational1
    h2 = HenselCode::TruncatedFinitePadicExpansion.new prime, exponent2, rational2
    expected_error_message = "#{h1} has exponent #{h1.prime} while #{h2} has prime #{h2.prime}"

    assert_raises(HenselCode::HenselCodesWithDifferentExponents, expected_error_message) { h1 * h2 }
  end

  def test_multiplication_of_hensel_codes_with_different_primes_different_exponents
    prime1, prime2 = random_distinct_primes(2, 9)
    exponent1 = 2
    exponent2 = 3
    rational1 = @rationals.sample
    rational2 = @rationals.sample
    h1 = HenselCode::TruncatedFinitePadicExpansion.new prime1, exponent1, rational1
    h2 = HenselCode::TruncatedFinitePadicExpansion.new prime2, exponent2, rational2
    expected_error_message =  "#{h1} has prime #{h1.prime} and exponent #{h1.exponent} while #{h2} has prime #{h2.prime} and exponent #{h2.exponent}"

    assert_raises(HenselCode::HenselCodesWithDifferentPrimesAndExponents, expected_error_message) { h1 * h2 }
  end

  def test_multiplication_of_hensel_code_and_some_other_object
    prime = random_prime(16)
    exponent1 = 2
    rational = @rationals.sample
    h1 = HenselCode::TruncatedFinitePadicExpansion.new prime, exponent1, rational
    h2 = h1.hensel_code + 1
    expected_error_message = "#{h1} is a #{h1.class} while #{h2} is a #{h2.class}"

    assert_raises(HenselCode::IncompatibleOperandTypes, expected_error_message) { h1 * h2 }
  end

  # division

  def test_valid_division
    prime = random_prime(16)
    exponent = 2
    rational1 = @rationals.sample
    rational2 = @rationals.sample
    h1 = HenselCode::TruncatedFinitePadicExpansion.new prime, exponent, rational1
    h2 = HenselCode::TruncatedFinitePadicExpansion.new prime, exponent, rational2
    h3 = h1 / h2
    h2_hensel_code_inverse = mod_inverse(h2.hensel_code, h1.modulus)
    expected_hensel_code = (h1.hensel_code * h2_hensel_code_inverse) % h1.modulus

    assert_equal HenselCode::TruncatedFinitePadicExpansion, h3.class
    assert_equal expected_hensel_code, h3.hensel_code
    assert_equal prime, h3.prime
    assert_equal exponent, h3.exponent
    assert_equal rational1 / rational2, h3.to_r
  end

  def test_division_of_hensel_codes_with_different_primes_same_exponent
    prime1, prime2 = random_distinct_primes(2, 16)
    exponent = 2
    rational1 = @rationals.sample
    rational2 = @rationals.sample
    h1 = HenselCode::TruncatedFinitePadicExpansion.new prime1, exponent, rational1
    h2 = HenselCode::TruncatedFinitePadicExpansion.new prime2, exponent, rational2
    expected_error_message = "#{h1} has prime #{h1.prime} while #{h2} has prime #{h2.prime}"

    assert_raises(HenselCode::HenselCodesWithDifferentPrimes, expected_error_message) { h1 / h2 }
  end

  def test_division_of_hensel_codes_with_same_primes_different_exponents
    prime = random_prime(16)
    exponent1 = 2
    exponent2 = 3
    rational1 = @rationals.sample
    rational2 = @rationals.sample
    h1 = HenselCode::TruncatedFinitePadicExpansion.new prime, exponent1, rational1
    h2 = HenselCode::TruncatedFinitePadicExpansion.new prime, exponent2, rational2
    expected_error_message = "#{h1} has exponent #{h1.prime} while #{h2} has prime #{h2.prime}"

    assert_raises(HenselCode::HenselCodesWithDifferentExponents, expected_error_message) { h1 / h2 }
  end

  def test_division_of_hensel_codes_with_different_primes_different_exponents
    prime1, prime2 = random_distinct_primes(2, 9)
    exponent1 = 2
    exponent2 = 3
    rational1 = @rationals.sample
    rational2 = @rationals.sample
    h1 = HenselCode::TruncatedFinitePadicExpansion.new prime1, exponent1, rational1
    h2 = HenselCode::TruncatedFinitePadicExpansion.new prime2, exponent2, rational2
    expected_error_message =  "#{h1} has prime #{h1.prime} and exponent #{h1.exponent} while #{h2} has prime #{h2.prime} and exponent #{h2.exponent}"

    assert_raises(HenselCode::HenselCodesWithDifferentPrimesAndExponents, expected_error_message) { h1 / h2 }
  end

  def test_division_of_hensel_code_and_some_other_object
    prime = random_prime(16)
    exponent1 = 2
    rational = @rationals.sample
    h1 = HenselCode::TruncatedFinitePadicExpansion.new prime, exponent1, rational
    h2 = h1.hensel_code + 1
    expected_error_message = "#{h1} is a #{h1.class} while #{h2} is a #{h2.class}"

    assert_raises(HenselCode::IncompatibleOperandTypes, expected_error_message) { h1 / h2 }
  end
end