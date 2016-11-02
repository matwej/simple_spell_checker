require 'levenshtein'

module SimpleSpellChecker
  module DistanceAdapter

    module Gem

      def self.distance(a, b)
        Levenshtein.distance a, b
      end

    end

    module Custom

      def self.distance(a, b)
        a = a.downcase
        b = b.downcase

        n = a.length
        m = b.length
        max = n/2

        return m if n == 0
        return n if m == 0
        return n if (n-m).abs > n/2

        arr = (0..m).to_a
        out = nil
        a.each_char.with_index do |ch1, i|
          k = i+1
          b.each_char.with_index do |ch2, j|
            cost = (ch1 == ch2) ? 0 : 1
            out = [arr[j+1]+1, k+1, arr[j]+cost].min
            arr[j] = k
            k = out
          end
          arr[m] = k
        end
        return out
      end

    end

  end
end