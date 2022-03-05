# frozen_string_literal: true

module HenselCode
  # base hensel code class
  class PAdicBase
    include Tools
    include PAdicVerifier

    attr_accessor :prime, :exponent, :rational, :hensel_code, :n
    private :prime=, :exponent=, :rational=, :hensel_code=

    def initialize(prime, exponent, number)
      @prime = prime
      @exponent = exponent
      @n = Integer.sqrt(((prime**exponent) - 1) / 2)
      valid_number?(number)
      encode
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

    def +(other)
      valid?(other)
      evaluate("+", other)
    end

    def -(other)
      valid?(other)
      evaluate("-", other)
    end

    def *(other)
      valid?(other)
      evaluate("*", other)
    end

    def /(other)
      valid?(other)
      evaluate("/", other)
    end

    def replace_prime(new_prime)
      replace_attribute("prime=", new_prime, 0)
    end

    def replace_exponent(new_exponent)
      replace_attribute("exponent=", new_exponent, 0)
    end

    def replace_rational(new_rational)
      replace_attribute("rational=", new_rational, 0)
    end

    def replace_hensel_code(new_hensel_code)
      valid_hensel_code?(new_hensel_code)
      replace_attribute("hensel_code=", new_hensel_code, 1)
    end

    private

    def replace_attribute(attribute, new_value, order)
      send(attribute, new_value)
      order.zero? ? [encode, decode] : [decode, encode]
      self
    end
  end
end
