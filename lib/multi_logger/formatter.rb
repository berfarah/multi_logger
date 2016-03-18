module MultiLogger
  # Contains format
  module Formatter
    class << self
      # -----------------------------------------------
      # Custom formatting for the logger - has colors
      # if you're looking at it from the terminal
      # -----------------------------------------------

      def format(name)
        colors = std?(name) ? format_colors : {}
        proc do |severity, datetime, progname, msg|
          "#{severity_color(severity, colors)}#{spacing(severity)}"\
          "#{colors[:clear]}[#{date_format(datetime)}] "\
          "#{progname}: #{msg}\n"
        end
      end

      private

        def std?(name)
          [:stdout, :stdin, :stderr].include? name
        end

        def format_colors
          @format_colors ||= {
            fatal:   "\e[41;1;37m",
            error:   "\e[31m",
            success: "\e[32m",
            warn:    "\e[33m",
            info:    "\e[36m",
            clear:   "\e[0m" }
        end

        def severity_color(severity, colors)
          colors.fetch(severity.downcase.to_sym, "")
        end

        def spacing(word, spacing = 6)
          word.dup << " " * (spacing - word.length)
        end

        def date_format(datetime)
          datetime.strftime("%Y-%m-%d %H:%M:%S")
        end
      end
  end
end
