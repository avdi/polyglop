require "rubygems"
require "bundler"
Bundler.setup

require 'cucumber'
require 'cucumber/rake/task'
require 'pathname'

ROOT = Pathname(File.dirname(__FILE__))

desc "List implementations"
task :implementations do |t|
  puts *(ROOT + 'bin').entries.grep(/\w+/).map{|f| f.basename }
end

namespace :cucumber do
  Cucumber::Rake::Task.new(:default) do |t|
    t.cucumber_opts = "features --format pretty"
    t.profile = "default"
  end

  Cucumber::Rake::Task.new(:extra_credit) do |t|
    t.cucumber_opts = "features --format pretty"
    t.profile = "extra_credit"
  end
end

desc "Basic challenge acceptance tests"
task :default => ['cucumber:default']

desc "Extra credit tests"
task :extra_credit => ['cucumber:extra_credit']

# Make cucumber.el happy
task :cucumber => ['cucumber:extra_credit']

