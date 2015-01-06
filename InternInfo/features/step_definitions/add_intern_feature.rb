require 'pry'
## Given Block
Given(/^I am viewing "(.*?)"$/) do |add_intern|
  visit '/add_intern'
end


## When Block
When(/^I fill in "(.*?)" with "(.*?)"$/) do |intern_name, kundan|
  fill_in 'intern_name', :with => 'kundan'
end

When(/^I fill In "(.*?)" with "(.*?)"$/) do |profile, developer|
  fill_in 'profile', :with => 'developer'
end

When(/^I fill In "(.*?)" with "(.*?)"$/) do |working_on, ruby|
  fill_in 'working_on', :with => 'ruby'
end

When(/^I fill In "(.*?)" with "(.*?)"$/) do |skill, c, java, php|
  fill_in 'skill', :with => 'c,java,php'
end

When(/^I press on Button "(.*?)"$/) do |add|
  click_on("add")
end


## Then Block
Then(/^I am viewing "(.*?)"\.$/) do |index|
  visit "index"
end

