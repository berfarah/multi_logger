require 'multi_logger/version'
require "multi_logger/levels"
require "multi_logger/type/default_logger"
require "multi_logger/type/stdout_logger"
require "multi_logger/type/null_logger"

# Alias from parent-class to sub-class
module MultiLogger
  def self.new(**args)
    Logger.new(**args)
  end

  # Our logger with multi-logging output
  class Logger
    attr_reader :loggers, :opts, :level

    def initialize(level: :info, max_files: 0, max_size: 0, loggers: [])
      @loggers = {}
      @level = level
      @opts = [max_files, max_size]
      loggers.each(&method(:add))
    end

    def add(name:, location: nil, level: @level, logger: :default)
      @loggers[name] = send(logger, location, *@opts, level: level || @level)
      self
    end

    def level(name, level)
      @loggers[name].level = ::Logger::Severity.const_get(level.upcase)
      self
    end

    def only(name)
      @loggers[name]
    end

    def remove(name)
      @loggers[name].close
      @loggers.delete(name)
      self
    end

    def close
      @loggers.values.map(&:close)
      self
    end

    LEVELS.each do |level|
      define_method(level) do |*args|
        @loggers.values.each { |l| l.send(level, *args) }
      end
    end

    [:default, :stdout, :web, :null].each do |name|
      define_method(name) do |*args|
        MultiLogger.const_get(:"#{name.capitalize}Logger").new(*args)
      end
    end
  end
end
