# frozen_string_literal: true

$stdout.sync = true

require "optparse"

module StagedBox
  class Command
    def self.run(args = ARGV.dup)
      new(args).run
    end

    def initialize(args)
      @args = options_parser.parse!(args)
    end

    def run
    end

private

    def options_parser
      @options_parser ||= OptionParser.new do |opt|
        opt.banner = "Usage: staged_box [options] start|stop|restart|run"
        opt.on('-h', '--help', 'show help') do
          $stdout.puts opt
          exit(0)
        end
        opt.on "-v", "--version", "print version" do |_arg|
          puts "StagedBox #{StagedBox::VERSION::STRING}"
          exit(0)
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
