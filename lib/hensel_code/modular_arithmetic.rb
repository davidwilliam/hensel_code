# frozen_string_literal: true

module HenselCode
  # modular arithmetic class
  module ModularArithmetic
    def cauchy_product(prime, coefficients1, coefficients2)
      product = []
      carry = 0
      (0..coefficients1.size - 1).each do |i|
        sum = 0
        (0..i).each { |j| sum += (coefficients1[j] * coefficients2[i - j]) }
        product << ((carry + sum) % prime)
        carry = (carry + sum) / prime
      end
      product
    end

    def multiplication(prime, coefficients1, coefficients2)
      partial_multiplications = []
      coefficients2.each_with_index do |c1, i|
        rows = multiplication_inner_loop(prime, coefficients1, coefficients2, c1, i)
        partial_multiplications << rows
        rows.append(*([0] * i))
      end
      sum_of_partial_multiplications(partial_multiplications)
    end

    def division(prime, coefficients1, coefficients2)
      g = coefficients2   
      q, n = [], coefficients1.dup
      puts "n = #{n}"
      puts "g = #{g}"
      # while n.length >= g.length
        # q << Float(n[0]) / g[0]
        q << (n[0] * mod_inverse(g[0], prime)) % prime
        n.reverse.zip(g.reverse).each_with_index do |pair, i|
          n[i] = (pair[0] - q[0] * pair[1]) % prime
        end
        # n.shift
      # end
      q = [0] if q.empty?
      n = [0] if n.empty?
      [q, n]
    end

    # [[229], [0, 28, 86]]

    private

    def multiplication_inner_loop(prime, coefficients1, coefficients2, c1_, index)
      rows = []
      carry = 0
      coefficients1.each_with_index do |c2, j|
        rows << ((carry + (c1_ * c2)) % prime)
        carry = (carry + (c1_ * c2)) / prime
        (rows << carry).reverse!.insert(0, *([0] * (j - index))) if j == coefficients2.size - 1
      end
      rows
    end

    def sum_of_partial_multiplications(partial_multiplications)
      carry = 0
      sum = []
      partial_multiplications.map(&:reverse).transpose.map do |x|
        sum << ((carry + x.reduce(:+)) % prime)
        carry = (carry + x.reduce(:+)) / prime
      end
      sum
    end
  end
end
