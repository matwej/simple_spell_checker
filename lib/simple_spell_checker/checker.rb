require 'simple_spell_checker/bk_tree'

module SimpleSpellChecker
  class Checker
    include BkTree

    # Dictionary file in UTF-8 - word per line
    # Adapters for distance: :gem, :custom
    def initialize(dictionary_file_path, distance_adapter = :gem)
      @tree = Tree.new distance_adapter
      # start = Time.now
      File.open(dictionary_file_path, "r") do |f|
        f.readlines.each do |word|
          @tree.add word.delete!("\n")
        end
      end
      # puts "Tree created after #{(((Time.now)-start)*1000).to_i}ms."
    end

    # words delimited by space
    # output file - "output.txt"
    # encoding: ISO-8859-1
    def analyse(file_path)
      fixed = 0
      words = []
      File.open(file_path, "r:iso-8859-1") do |f|
        words = f.readlines(sep=" ")
        words.dup.each_with_index do |word, i|
          word.delete!(" ")
          match, dist = @tree.best word.downcase
          if !match.nil? && dist != 0
            fixed+=1
            words[i] = capitalize_if_needed(word, match)
            # puts "#{word} - #{match}"
          end
        end
      end
      # print "file: #{file_path}\nwords: #{words.size}\nfixed words:#{((fixed.to_f/(words.size).to_f)*100).round(2)}%\n"
      save words, file_path
    end

    private

    def capitalize_if_needed(word, out)
      if word == word.capitalize
        out.capitalize
      else
        out
      end
    end

    def save(words, file_path)
      File.open("output.txt", "w") do |f|
        words.each do |word|
          f.write "#{word} "
        end
      end
    end

  end
end