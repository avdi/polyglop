WHITESPACE = "\t\r\n "

When /^I start a new game with the file "([^\"]*)"$/ do |filename|
  story_path = File.expand_path("../../data/#{filename}", File.dirname(__FILE__))
  exec_path = File.expand_path("../../bin/play.rb", File.dirname(__FILE__))

  Given %Q(a process from command "#{exec_path} #{story_path}")
  When %Q(I execute the process)
end

When /^I pick up the (.*)$/ do |term|
  When "I enter \"take #{term}\""
end

Then /^I should be (.*)$/ do |text|
  Then %Q(I should see the following output:), text
end

Then /^I should see:$/ do |text|
  Then %Q(I should see the following output:), text
end

Then /^I should see "([^\"]*)"$/ do |text|
  Then %Q(I should see the following output:), text
end

Then /^I should not see "([^\"]*)"$/ do |text|
  Then %Q(I should not see the following output:), text
end

Then /^I should have the (.*)$/ do |object|
  When "I enter \"inventory\""
  Then "I should see \"#{object}\""
end

Given /^I am in the building$/ do
  When "I enter \"east\""
end

Given /^I am at the grate$/ do
  Given "I am in the building"
   When "I pick up the keys"
    And "I pick up the bottle"
    And "I pick up the food"
    And "I enter \"west\""
    And "I enter \"south\""
    And "I enter \"south\""
    And "I enter \"south\""
end

