# frozen_string_literal: true

require_relative "staged_box/command"
require_relative "staged_box/bootloader"
require_relative "staged_box/boxer"
require_relative "staged_box/config"
require_relative "staged_box/version"

module StagedBox
  class Error < StandardError; end
end
