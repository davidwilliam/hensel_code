# frozen_string_literal: true

module HenselCode
  # polynomial class
  class Polynomial
    include HenselCode::Tools

    attr_accessor :prime, :coefficients, :fixed_length

    def initialize(prime, coefficients, fixed_length = true)
      @prime = prime
      @coefficients = coefficients
      @fixed_length = fixed_length
    end

    def + other
      if fixed_length
        new_coefficients = [coefficients, other.coefficients].transpose.map{|x| x.reduce(:+) % prime }
      end
      self.class.new prime, new_coefficients
    end

    def - other
      if fixed_length
        new_coefficients = [coefficients, other.coefficients].transpose.map{|x| x.reduce(:-) % prime }
      end
      self.class.new prime, new_coefficients
    end

    def * other
      new_coefficients = modular_cauchy_product(prime, self.coefficients, other.coefficients)
      self.class.new prime, new_coefficients
    end

    def / other
      if fixed_length
        new_coefficients = [coefficients, other.coefficients].transpose.map{|x| (x[0] * mod_inverse(x[1], prime)) % prime }
      end
      self.class.new prime, new_coefficients
    end

    def inverse
      new_coefficients = coefficients.map{|c| mod_inverse(c, prime)}
      self.class.new prime, new_coefficients
    end

    private

    def multiplication_setup
      [[], [], 0, 0]
    end

    def multiplication_checkpoint(res_, res, carry, row)
      res_ << carry
      res_.reverse!
      res += res_
      res_ = []
      carry = 0
      res += [0] * row
      row += 1
      [res_, res, carry, row]
    end

    def mul_carry(prime, carry, op1, op2)
      [(carry + op1 * op2) / prime, (carry + op1 * op2) % prime]
    end

  end
end