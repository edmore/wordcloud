module WordCloud
  require 'set'

  class Engine
    attr_reader :words, :excluded_words

    def initialize
      @words = Hash.new(0)
      @excluded_words = Hash.new(0)
    end

    def process(row)
      if row.first.class == String
        row.first.split.each do |w|
          w = w.downcase
          @words[w] += 1 unless @excluded_words[w] == true
        end
      end
    end

    def process_exclusion(row)
      if row.first.class == String
          @excluded_words[row.first.downcase] = true
      end
    end
  end
end
