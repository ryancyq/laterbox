# frozen_string_literal: true

require "spec_helper"

describe Laterbox::Config do

  it "initialize with defaults" do
    config = described_class.new
    expect(config.default_log_level).to eq(Laterbox::Config::DEFAULT_LOG_LEVEL)
    expect(config.boxes).to eq(Laterbox::Config::DEFAULT_BOXES)
    expect(config.concurrency).to eq(Laterbox::Config::DEFAULT_CONCURRENCY)
    expect(config.buffer_size).to eq(Laterbox::Config::DEFAULT_BUFFER_SIZE)
  end
end