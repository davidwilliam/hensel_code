# frozen_string_literal: true

if ENV["COVERAGE"] == "on"
  require "codecov"
  require "simplecov"
  require "simplecov-console"

  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(
    [
      SimpleCov::Formatter::HTMLFormatter,
      SimpleCov::Formatter::Console,
      SimpleCov::Formatter::Codecov
    ]
  )

  SimpleCov.start do
    # TODO: fix test coverage
    # minimum_coverage 100

    add_filter "test"
  end
end

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "hensel_code"

require "minitest/autorun"
require "minitest/reporters"
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(color: true)]
