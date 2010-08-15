require "rubygems"
require "bundler"
Bundler.setup

require 'cucumber'
require 'cucumber/rake/task'
require 'pathname'

ROOT            = Pathname(File.dirname(__FILE__))
PROFILES        = %w[default extra_credit]
IMPLEMENTATIONS = %w[ruby-stdlib clojure]

desc "Run all implementations"
task :all do
end

desc "Remove generated files"
task :clean do
  rm_f Dir.glob("*.log")
  rm_f Dir.glob("*.log.?")
end

desc "List implementations"
task :implementations do |t|
  puts *IMPLEMENTATIONS
end

namespace :cucumber do
  PROFILES.each do |profile|
    Cucumber::Rake::Task.new(profile) do |t|
      t.cucumber_opts = "features --format pretty"
      t.profile = profile.to_s
    end
  end
end

namespace :acceptance do
  PROFILES.each do |profile|
    desc "Run #{profile} acceptance tests on specified implementation"
    task profile, :impl do |t, args|
      unless args[:impl]
        raise ":impl must be provided (one of #{IMPLEMENTATIONS.join(', ')})"
      end
      begin
        old_impl = ENV['IMPL']
        ENV['IMPL'] = args[:impl]
        Rake::Task["cucumber:#{profile}"].invoke
      ensure
        if old_impl then ENV['IMPL'] = old_impl else ENV.delete('IMPL') end
      end
    end
  end

  IMPLEMENTATIONS.each do |impl|
    impl_task = task impl do
    end
    Rake::Task["all"].enhance([impl_task.name])
    namespace impl do
      PROFILES.each do |profile|
        desc "Run #{profile} tests on #{impl}"
        t = task profile => ["bin/#{impl}"] do |t|
          puts "\n\n=== Exercising #{impl} - #{profile} ==="
          Rake::Task["acceptance:#{profile}"].invoke(impl)
        end
        impl_task.enhance([t.name])
      end
    end
  end
end

desc "Basic challenge acceptance tests"
task :default => ['all']

# Make cucumber.el happy
task :cucumber => ['cucumber:extra_credit']

################################################################################
# Clojure
################################################################################

file "bin/clojure" => ["lib/polyglot-clojure/adventure.jar"]
file "lib/polyglot-clojure/adventure.jar" =>
  FileList["lib/polyglot-clojure/src/*.clj"] do |t|

  cd("lib/polyglop-clojure") do
    sh %Q(lein uberjar adventure.jar)
  end
end

task :clean do
  cd("lib/polyglop-clojure") do
    rm_f 'adventure.jar'
    rmtree 'classes'
  end
end

