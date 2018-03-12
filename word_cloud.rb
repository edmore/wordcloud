#!/usr/bin/env ruby

module WordCloud
  require 'optparse'
  require_relative 'lib/parser.rb'

  # default options
  inputfile = "input.csv"
  outputfile = "output.csv"

  # parse arguments
  ARGV.options do |opts|
    opts.on("-i", "--inputfile=val", String)   { |val| inputfile = val }
    opts.on("-o", "--outputfile=val", String)   { |val| outputfile = val }
    opts.on_tail("-h", "--help") do
      puts opts
      exit
    end
    opts.parse!
  end

  # parse file
  p = Parser.new(inputfile, true)
  # export to csv
  CSV.open("#{outputfile}", "wb") do |csv|
     p.words.sort_by{|_key, value| value}.reverse.to_a.each {|elem| csv << elem}
   end
end
