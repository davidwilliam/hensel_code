# frozen_string_literal: true

module HenselCode
  # finite p-adic expansion hensel code class
  class FinitePadicExpansion < PAdicBase
    attr_accessor :polynomial

    def modulus
      prime
    end

    def to_a
      hensel_code
    end

    def to_truncated
      TruncatedFinitePadicExpansion.new(prime, exponent, rational)
    end

    def to_s
      hensel_code.map.with_index do |h, i|
        "#{h}#{polynomial_variable(i)}"
      end.join(" + ")
    end

    def inspect
      "<HenselCode: #{polynomial_form}>"
    end

    def inverse
      new_hensel_code = polynomial.inverse.coefficients
      self.class.new prime, exponent, new_hensel_code
    end

    private

    def evaluate(operation, other)
      new_hensel_code = polynomial.send(operation, other.polynomial).coefficients
      self.class.new prime, exponent, new_hensel_code
    end

    def polynomial_variable(index)
      i = index > 1 ? 2 : index
      ["", "p", "p^#{index}"][i]
    end

    def polynomial_form
      to_s
    end

    def valid_number?(number)
      if number.is_a?(Rational)
        @rational = number
      elsif number.is_a?(Array) && number.map(&:class).uniq == [Integer] && number.size == exponent
        @hensel_code = number
        decode
      else
        message = "number must be a Rational or an\
        Array of integers of size #{exponent}"
        raise WrongHenselCodeInputType, message
      end
    end

    def valid_hensel_code?(new_hensel_code)
      conditions = [
        new_hensel_code.is_a?(Array),
        new_hensel_code.map(&:class).uniq == [Integer],
        new_hensel_code.size == exponent
      ]
      message = "must be an array of integers of size #{exponent}"
      raise WrongHenselCodeInputType, message unless conditions.uniq == [true]
    end

    def encode
      @hensel_code = rational_to_padic_digits
      @polynomial = Polynomial.new prime, hensel_code
    end

    def decode
      number = 0
      hensel_code.each_with_index { |d, i| number += d * (prime**i) }
      @rational = TruncatedFinitePadicExpansion.new(prime, exponent, number).to_r
    end

    def rational_to_padic_digits
      digits = [rational_to_integer(rational)]
      alpha = rational - digits.last
      (exponent - 1).times do
        alpha = reduce_rational_in_terms_of_prime(alpha)
        digits << rational_to_integer(alpha)
        alpha -= digits.last
      end
      digits
    end

    def reduce_rational_in_terms_of_prime(alpha)
      divisor_numerator = alpha.numerator.gcd(prime)
      divisor_denominator = alpha.denominator.gcd(prime)
      if divisor_numerator != 1
        alpha /= divisor_numerator
      elsif divisor_denominator != 1
        alpha *= divisor_denominator
      end
      alpha
    end

    def rational_to_integer(rat)
      (rat.numerator * mod_inverse(rat.denominator, prime)) % prime
    end
  end
end
