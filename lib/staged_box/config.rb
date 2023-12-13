# frozen_string_literal: true

require "yaml"

module StagedBox
  class Config

    DEFAULT_LOG_LEVEL = 'info'.freeze
    DEFAULT_BOXES = [].freeze
    DEFAULT_CONCURRENCY = 3
    DEFAULT_BUFFER_SIZE = 1

    attr_accessor :default_log_level, :boxes, :concurrency, :buffer_size

    def initialize(options = {})
      set_defaults
      @default_log_level = options[:default_log_level] if options.key?(:default_log_level)
      @boxes             = options[:boxes] if options.key?(:boxes)
      @concurrency        = options[:concurrency] if options.key?(:concurrency)
      @buffer_size       = options[:buffer_size] if options.key?(:buffer_size)
    end

    def to_hash
      {
        default_log_level: @default_log_level,
        boxes:             @boxes,
        concurrency:       @concurrency,
        buffer_size:       @buffer_size
      }
    end

    def self.from_file(file_path)
      raise ArgumentError.new("No such config file #{file_path}") unless File.exist?(file_path)

      file_content = File.read(file_path)
      options = YAML.safe_load(file_content, permitted_classes: [Symbol], aliases: true) || {}
      
      if options.respond_to?(:deep_symbolize_keys!)
        options.deep_symbolize_keys!
      else
        symbolize_keys_deep!(options)
      end

      new(options)
    end

  private

    def set_defaults
      @default_log_level = DEFAULT_LOG_LEVEL
      @boxes             = DEFAULT_BOXES
      @concurrency        = DEFAULT_CONCURRENCY
      @buffer_size       = DEFAULT_BUFFER_SIZE
    end

    def symbolize_keys_deep!(hash)
      hash.keys.each do |key|
        symkey = key.respond_to?(:to_sym) ? key.to_sym : key
        hash[symkey] = hash.delete(key)
        symbolize_keys_deep!(hash[symkey]) if hash[symkey].is_a? Hash
      end
    end
  end
end
