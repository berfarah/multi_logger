require "logger"
require "multi_logger/formatter"

class Logger
  # Just here to prevent writing headers to logfiles
  class LogDevice; def add_log_header(*); end; end
end

module MultiLogger
  # Our default logger
  class DefaultLogger < ::Logger
    def initialize(io, *args, formatter: :default, level:, sync: true)
      io = File.open(io, 'a') unless io.is_a?(IO)
      io.sync = true if sync
      super(io, *args)
      self.level = ::Logger::Severity.const_get(level.upcase)
      self.formatter = Formatter.format(formatter)
    end
  end
end
