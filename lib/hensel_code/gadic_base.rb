# frozen_string_literal: true

module HenselCode
  # base hensel code class
  class GAdicBase
    include Tools
    include GAdicVerifier

    attr_accessor :primes, :exponent, :rational, :hensel_code, :g, :n
    private :primes=, :exponent=, :rational=, :hensel_code=

    def initialize(primes, exponent, number)
      can_initilize?
      @primes = primes
      @exponent = exponent
      @g = primes.inject(:*)
      @n = Integer.sqrt(((g**exponent) - 1) / 2)
      valid_number?(number)
      encode
      decode
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

    def replace_primes(new_primes)
      replace_attribute("primes=", new_primes, 0)
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

    def can_initilize?
      message = "#{self.class} can only be inherited."
      raise NonInitializableClass, message if instance_of?(HenselCode::GAdicBase)
    end

    def replace_attribute(attribute, new_value, order)
      send(attribute, new_value)
      order.zero? ? [encode, decode] : [decode, encode]
      self
    end
  end
end
