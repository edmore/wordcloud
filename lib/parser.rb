module WordCloud
  require 'csv'
  require_relative 'engine.rb'

  class Parser
    attr_reader :words, :excluded_words

    def initialize(file, exclude = false)
      @inputfile = file
      @excludefile = nil
      @words = nil

      @exclude = exclude
      @excludedfile = 'excluded.csv' if @exclude
      @engine = Engine.new
      run!
    end

    def run!
      raise "Input file not found" unless File.exists?(@inputfile)
      raise "Exclusion file not found" unless File.exists?(@excludedfile) if @exclude

      # Process excluded words file
      if @exclude
        begin
          CSV.foreach(@excludedfile) do |row|
            @engine.process_exclusion(row)
          end
        rescue Exception => e
          raise "#{e.message}"
        end
      end

      # Process input file
      begin
        CSV.foreach(@inputfile) do |row|
          @engine.process(row)
        end
      rescue Exception => e
        raise "#{e.message}"
      end

      @words = @engine.words
      @excluded_words = @engine.excluded_words
    end
  end
end
