require "multi_logger/levels"

module MultiLogger
  # For when logging is disabled
  class NullLogger
    def initialize(*); end

    MultiLogger::LEVELS.each do |name|
      define_method(name) { |*| }
    end
  end
end
