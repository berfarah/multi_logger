require 'multi_logger/formatter'
require "time"

describe MultiLogger::Formatter do
  it "should format accordingly" do
    proc = MultiLogger::Formatter.format("example")
    time = "2015-06-29 15:08:17"
    out  = "INFO  [#{time}] : Test message\n"
    expect(proc.call("INFO", Time.parse(time), nil, "Test message")).to eq(out)
  end
end
