require "logger"

# Logger levels
module MultiLogger
  LEVELS = ::Logger::Severity.constants.map(&:downcase)
end
