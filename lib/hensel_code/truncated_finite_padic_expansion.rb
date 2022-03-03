# frozen_string_literal: true

module HenselCode
  # truncated finite p-adic expansion hensel code class
  class TruncatedFinitePadicExpansion
    include Tools
    include TFPEVerifier

    attr_accessor :prime, :exponent, :rational, :hensel_code, :n

    def initialize(prime, exponent, number)
      @prime = prime
      @exponent = exponent
      @n = Integer.sqrt((modulus - 1) / 2)

      valid_number?(number)
      encode
    end

    def modulus
      prime**exponent
    end

    def numerator
      rational.numerator
    end

    def denominator
      rational.denominator
    end

    def to_r
      decode
      rational
    end

    def to_i
      hensel_code
    end

    def to_s
      hensel_code.to_s
    end

    def replace_prime(new_prime)
      self.prime = new_prime
      encode
      decode
      self
    end

    def replace_exponent(new_exponent)
      self.exponent = new_exponent
      encode
      decode
      self
    end

    def replace_rational(new_rational)
      self.rational = new_rational
      encode
      decode
      self
    end

    def +(other)
      valid?(other)
      self.class.new prime, exponent, (hensel_code + other.hensel_code) % modulus
    end

    def -(other)
      valid?(other)
      self.class.new prime, exponent, (hensel_code - other.hensel_code) % modulus
    end

    def *(other)
      valid?(other)
      self.class.new prime, exponent, (hensel_code * other.hensel_code) % modulus
    end

    def /(other)
      valid?(other)
      h2_hensel_code_inverse = mod_inverse(other.hensel_code, modulus)
      self.class.new prime, exponent, (hensel_code * h2_hensel_code_inverse) % modulus
    end

    private

    def valid_number?(number)
      case number
      when Rational
        @rational = number
      when Integer
        @hensel_code = number
        decode
      else
        raise WrongHenselCodeInputType, "number must be a Rational or an\
                                        Integer object and it was a #{number.class}"
      end
    end

    def encode
      denominator_inverse = mod_inverse(denominator, modulus)
      @hensel_code = (numerator * denominator_inverse) % modulus
    end

    def decode
      eea_vars = eea_core(modulus, hensel_code, n)
      i, x, y = eea_vars[2..4]
      @rational = Rational(*[x, y].map { |e| ((-1)**(i + 1)) * e })
    end
  end
end
