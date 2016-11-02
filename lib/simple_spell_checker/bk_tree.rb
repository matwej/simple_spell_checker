require 'simple_spell_checker/distance_adapter'

module SimpleSpellChecker
  module BkTree

    class Node
      attr_reader :word, :children

      def initialize(word, adapter)
        @word = word
        @adapter = adapter
        @children = {}
      end

      def add(word)
        cost = @adapter.distance word, @word
        child = children[cost]
        if child
          child.add word
        else
          children[cost] = Node.new(word, @adapter)
        end
      end

      def query(word, threshold, collected)
        dist = @adapter.distance word, self.word
        collected[self.word] = dist if dist <= threshold
        (-threshold..threshold).each do |th|
          child = children[dist + th]
          if child
            child.query word, threshold, collected
          end
        end
      end
    end

    class Tree

      MAX_INT = (2**(0.size * 8 -2) -1)

      def initialize(dist_adapter)
        @root = nil
        @adapter = DistanceAdapter.const_get dist_adapter.to_s.capitalize
      end

      def add(word)
        if @root
          @root.add word
        else
          @root = Node.new(word, @adapter)
        end
      end

      def query(word, threshold)
        collected = {}
        @root.query word, threshold, collected
        collected
      end

      def best(word)
        collected = query word, (word.length/3).to_i
        best = nil
        best_distance = MAX_INT
        collected.each do |k, v|
          if v < best_distance
            best = k
            best_distance = v
          end
        end
        [best, best_distance]
      end
    end

  end
end