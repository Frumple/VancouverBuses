#!/usr/bin/env ruby
require 'optparse'
require 'pp'
require 'slim'
require 'yaml'

class DeckGenerator
  def initialize(options)
    @options = options
    @cards = YAML.load_file(@options[:data])
    @template = Slim::Template.new(@options[:template], :pretty => true)
  end

  def output
    @template.render(self)
  end
end

def parse_command_line_options
  options = {}

  optparse = OptionParser.new {|opts|
    opts.banner = "Usage: deck_generator.rb --template TEMPLATE --data DATA"

    opts.on("-t", "--template TEMPLATE", "Slim template file") do |template|
      options[:template] = template
    end

    opts.on("-d", "--data DATA", "YAML data file") do |data|
      options[:data] = data
    end

    opts.on("-h", "--help", "Show this message"){
      puts opts
      exit
    }
  }
  optparse.parse!

  if options[:template].empty? or options[:data].empty?
    puts optparse
    exit
  end

  options
end

options = parse_command_line_options
deck_generator = DeckGenerator.new(options)
puts deck_generator.output