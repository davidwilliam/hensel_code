# frozen_string_literal: true

module HenselCode
  # polynomial class
  class Polynomial
    include HenselCode::Tools
    include HenselCode::ModularArithmetic

    attr_accessor :prime, :coefficients, :fixed_length

    def initialize(prime, coefficients, fixed_length: true)
      @prime = prime
      @coefficients = coefficients
      @fixed_length = fixed_length
    end

    def +(other)
      new_coefficients = [coefficients, other.coefficients].transpose.map { |x| x.reduce(:+) % prime } if fixed_length
      self.class.new prime, new_coefficients
    end

    def -(other)
      new_coefficients = [coefficients, other.coefficients].transpose.map { |x| x.reduce(:-) % prime } if fixed_length
      self.class.new prime, new_coefficients
    end

    def *(other)
      new_coefficients = multiplication(prime, coefficients, other.coefficients)
      self.class.new prime, new_coefficients[0..coefficients.size - 1]
    end

    def /(other)
      if fixed_length
        new_coefficients = [coefficients, other.coefficients].transpose.map do |x|
          (x[0] * mod_inverse(x[1], prime)) % prime
        end
      end
      self.class.new prime, new_coefficients
    end

    def inverse
      new_coefficients = polynomial_inverse(prime, coefficients)
      self.class.new prime, new_coefficients
    end

    def mul(other)
      new_coefficients = multiplication(prime, coefficients, other.coefficients)
      self.class.new prime, new_coefficients
    end

    def div(other)
      new_coefficients = division(prime, coefficients,  other.coefficients)
      self.class.new prime, new_coefficients
    end
  end
end
