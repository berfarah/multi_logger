require 'multi_logger/logger'
require "tempfile"

describe MultiLogger::Logger do
  let(:instance) { described_class.new }
  let(:multi_log) do
    described_class.new loggers: [
      { name: :log_one, location: @log_one },
      { name: :log_two, location: @log_two }
    ]
  end

  before do
    @log_one = Tempfile.new("log_one")
    @log_two = Tempfile.new("log_two")
  end

  after do
    [@log_one, @log_two].each(&:close)
  end

  describe "#new" do
    it "should be aliased via MultiLogger" do
      expect(MultiLogger.new).to be_a(described_class)
    end

    it "should be able to add multiple logs" do
      multi_log.info "Test message"

      expect(@log_one.rewind && @log_one.read).not_to eq("")
      expect(@log_two.rewind && @log_two.read).not_to eq("")
    end
  end

  describe "#only" do
    it "should select just one log" do
      multi_log.only(:log_one).info "Test message"

      expect(@log_one.rewind && @log_one.read).not_to eq("")
      expect(@log_two.rewind && @log_two.read).to eq("")
    end
  end

  describe "#remove" do
    it "should remove a log" do
      multi_log.remove(:log_two).info "Test message"

      expect(@log_one.rewind && @log_one.read).not_to eq("")
    end
  end

  describe "#level" do
    it "should change the level of a steam" do
      multi_log.level(:log_one, :debug).debug "Test message"

      expect(@log_one.rewind && @log_one.read).not_to eq("")
      expect(@log_two.rewind && @log_two.read).to eq("")
    end
  end
end
