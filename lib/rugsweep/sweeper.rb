require "fileutils"
require "yaml"
require "paint"
require "pathname"

module Rugsweep
  class Sweeper
    def initialize(logger = STDOUT)
      @logger = logger
    end

    def log(str)
      @logger.puts str
    end

    def log_action(action, color, entry)
      log format("(%s) %s", Paint[action, color], entry)
    end

    def log_existing(entry, _target)
      log_action 'S', :yellow, entry
    end

    def log_move(entry, _target)
      log_action 'M', :green, entry
    end

    def sweep
      ensure_dumping_ground_exists
      filtered_entries.each do |entry|
        target = dumping_ground.join(entry.basename)
        if target.exist?
          log_existing(entry, target)
        else
          log_move(entry, target)
          FileUtils.mv entry, dumping_ground
        end
      end
    end

    private

    def ensure_dumping_ground_exists
      dumping_ground.directory? || dumping_ground.mkdir
    end

    CONFIG_FILE = ".rugsweep.yml"

    def base
      Pathname.new(".")
    end

    def entries
      base.children
    end

    def filtered_entries
      entries.reject do |entry|
        filter = Filter.new(entry, keep_files)
        filter.dotfile? || filter.ok?
      end
    end

    def config
      @config ||= File.open(CONFIG_FILE) { |f| YAML.load(f) }
    end

    def dumping_ground
      @dumping_ground ||= base.join config.fetch("rug")
    end

    def keep_files
      @keep_files ||= config.fetch("keep") + [dumping_ground.basename.to_s]
    end
  end

  class Filter
    def initialize(path, keepfiles)
      @path = path
      @keepfiles = keepfiles
    end

    def dotfile?
      filename.start_with? "."
    end

    def ok?
      @keepfiles.include? filename
    end

    private

    def filename
      @path.basename.to_s
    end
  end
end
