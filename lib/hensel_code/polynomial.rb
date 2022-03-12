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
      new_coefficients = addition(prime, coefficients, other.coefficients)
      self.class.new prime, new_coefficients
    end

    def -(other)
      new_coefficients = subtraction(prime, coefficients, other.coefficients)
      self.class.new prime, new_coefficients
    end

    def *(other)
      new_coefficients = multiplication(prime, coefficients, other.coefficients)
      self.class.new prime, new_coefficients[0..coefficients.size - 1]
    end

    def /(other)
      new_coefficients = (self * other.inverse).coefficients
      self.class.new prime, new_coefficients[0..coefficients.size - 1]
    end

    def inverse
      x = generate_padic_x
      two = generate_padic_constant_integer(2)
      x = (two * x) - (self * x * x) while (x * self).coefficients != [1] + Array.new(coefficients.size - 1, 0)
      x
    end

    private

    def generate_padic_x
      x_coefficients = [mod_inverse(coefficients[0], prime)] + Array.new(coefficients.size - 1) { rand(0..prime - 1) }
      self.class.new prime, x_coefficients
    end

    def generate_padic_constant_integer(number)
      self.class.new prime, [number] + Array.new(coefficients.size - 1, 0)
    end

    def mul(other)
      new_coefficients = multiplication(prime, coefficients, other.coefficients)
      self.class.new prime, new_coefficients
    end
  end
end
