ENV['CONSOLE_DEVICE'] ||= 'stdout'
ENV['LOG_LEVEL'] ||= '_min'

puts RUBY_DESCRIPTION

require_relative '../init.rb'

require 'aggregate/controls'

Controls = Aggregate::Controls

require 'test_bench'; TestBench.activate
