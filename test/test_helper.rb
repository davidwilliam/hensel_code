# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require 'codecov'
SimpleCov.formatter = SimpleCov::Formatter::Codecov

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "hensel_code"

require "minitest/autorun"
require "minitest/reporters"
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(color: true)]
