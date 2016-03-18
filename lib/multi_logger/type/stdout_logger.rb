require "multi_logger/type/default_logger"

module MultiLogger
  # Standard Output Logger
  class StdoutLogger < DefaultLogger
    def initialize(*args, level:)
      super($stdout, *args[1..-1], level: level, formatter: :stdout)
    end
  end
end
