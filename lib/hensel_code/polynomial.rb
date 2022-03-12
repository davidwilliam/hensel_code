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
      valid_prime?
      valid_coefficients?
    end

    def +(other)
      valid_operands?(other)
      new_coefficients = addition(prime, coefficients, other.coefficients)
      self.class.new prime, new_coefficients
    end

    def -(other)
      valid_operands?(other)
      new_coefficients = subtraction(prime, coefficients, other.coefficients)
      self.class.new prime, new_coefficients
    end

    def *(other)
      valid_operands?(other)
      new_coefficients = multiplication(prime, coefficients, other.coefficients)
      self.class.new prime, new_coefficients[0..coefficients.size - 1]
    end

    def /(other)
      valid_operands?(other)
      new_coefficients = (self * other.inverse).coefficients
      self.class.new prime, new_coefficients[0..coefficients.size - 1]
    end

    def inverse
      x = generate_padic_x
      two = generate_padic_constant_integer(2)
      x = (two * x) - (self * x * x) while (x * self).coefficients != [1] + Array.new(coefficients.size - 1, 0)
      x
    end

    def to_s
      coefficients.map.with_index do |c, i|
        "#{c}#{polynomial_variable(i)}"
      end.join(" + ")
    end

    def inspect
      "<Polynomial: #{polynomial_form}>"
    end

    def degree
      coefficients.size - 1
    end

    private

    def valid_prime?
      raise ArgumentError, "prime can't be nil" if @prime.nil?
      raise ArgumentError, "prime must be an integer" unless @prime.is_a?(Integer)
    end

    def valid_coefficients?
      coefficients_condition = @coefficients.is_a?(Array) && @coefficients.map(&:class).uniq == [Integer]
      raise ArgumentError, "coefficients can't be nil" if @coefficients.nil?
      raise ArgumentError, "coefficients must be an array" unless @coefficients.is_a?(Array)
      raise ArgumentError, "coefficients must be an array" unless coefficients_condition
    end

    def valid_operands?(other)
      s1 = coefficients.size
      s2 = other.coefficients.size
      raise WrongHenselCodeInputType, "polynomials must have same degree" if s1 != s2
      raise WrongHenselCodeInputType, "polynomials must have same prime" if prime != other.prime
    end

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

    def polynomial_form
      to_s
    end
  end
end
