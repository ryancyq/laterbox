# frozen_string_literal: true

require_relative "lib/staged_box/version"

Gem::Specification.new do |spec|
  spec.name = "staged_box"
  spec.version = StagedBox::VERSION::STRING
  spec.authors = ["ryancyq"]
  spec.email = ["ryancyq@gmail.com"]

  spec.summary = "A transactional inbox/outbox implementation for Ruby"
  spec.description = "A transactional inbox/outbox implementation for Ruby"
  spec.homepage = "https://github.com/ryancyq/staged_box"
  spec.license = "GPL-3.0-only"

  spec.metadata = {
    "homepage_uri" => spec.homepage,
    "allowed_push_host" => "https://rubygems.org",
    "source_code_uri" => "https://github.com/ryancyq/staged_box",
    "bug_tracker_uri" => "https://github.com/ryancyq/staged_box/issues",
    "documentation_uri" => "https://github.com/ryancyq/staged_box",
    "changelog_uri" => "https://github.com/ryancyq/staged_box/blob/main/CHANGELOG.md",
    "rubygems_mfa_required" => "true"
  }
  spec.required_ruby_version = ">= 2.6.0"

  spec.require_paths = ["lib"]
  spec.files = Dir["LICENSE", "README.md", "lib/**/*.rb", "CHANGELOG.md"]

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
