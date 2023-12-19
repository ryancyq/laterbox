# frozen_string_literal: true

$stdout.sync = true

require "optparse"

module Laterbox
  class Command
    INTERRUPT_SIGNALS = %w[INT TERM]

    def self.run(args = ARGV.dup)
      new(args).run
    end

    def initialize(args)
      @action = options_parser.parse!(args)
    end

    def run
      config = setup_config

      INTERRUPT_SIGNALS.each do |signal|
        Signal.trap(signal) do
          puts "Exiting due to #{signal}"
        end
      end

      app = ::Laterbox::Bootloader.new(config)
      app.start
    end

private

    def setup_config
      config = ::Laterbox::Config.new.to_hash

      if @config_file
        config.merge!(file_config(@config_file)) 
      else
        default_config_file = File.join("config", "laterbox.yml")
        config.merge!(file_config(default_config_file)) if File.exist?(default_config_file)
      end
      config.merge!(command_config)
      config
    end

    def file_config(path)
      return {} unless File.exist?(path)

      ::Laterbox::Config.from_file(path).to_hash 
    end

    def command_config
      {
        boxes: @box_names,
        concurrency: @concurrency
      }.compact
    end

    def options_parser
      @options_parser ||= OptionParser.new do |opt|
        opt.banner = "Usage: laterbox [options] start|stop|restart|run"
        opt.on('-h', '--help', 'show help') do
          $stdout.puts opt
          exit(0)
        end
        opt.on "-v", "--version", "print version" do |_arg|
          puts "Laterbox #{Laterbox::VERSION::STRING}"
          exit(0)
        end
        opt.on "-C", "--config PATH", "path to YAML config file" do |config_file|
          raise ArgumentError.new("No such file #{config_file}") unless File.exist?(config_file)
          @config_file = config_file 
        end
        opt.on('-c', '--concurrency=2', 'number of worker threads to spawn') do |concurrency|
          @concurrency = concurrency.to_i rescue nil
        end
        opt.on('-b', '--box=box_name_1,box_name_2', 'specify the box names') do |box_names|
          @box_names = box_names.split(',')
        end
      end
    end
  end
end
