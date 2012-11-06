# -- coding: utf-8

require "rubygems"
require "bundler/setup"
Bundler.require :default, :test
require "rspec-expectations"
require "rspec/matchers/built_in/be"

Dir["./spec/support/**/*.rb"].each{|file| require file }

if ENV["COVERAGE"]
  require "simplecov"
  SimpleCov.start
end

require File.expand_path("../../lib/fooooooo", __FILE__)

RSpec.configure do |config|
end
