# frozen_string_literal: true

require "staged_box"

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end