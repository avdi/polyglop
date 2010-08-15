require "rubygems"
require "bundler"
Bundler.setup

require "greenletters"
require 'greenletters/cucumber_steps'

module PolyglopHelpers
  def make_greenletters_process(command_line, options={})
    options[:timeout] = 10.0
    super(command_line, options)
  end
end

World(PolyglopHelpers)


