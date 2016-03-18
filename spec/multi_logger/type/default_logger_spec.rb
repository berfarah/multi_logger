require "tempfile"

describe MultiLogger::DefaultLogger do
  before { @log = Tempfile.new("log_one") }
  after  { @log.close }

  let(:example) { described_class.new(@log, level: :debug) }

  it "should instantiate with a level" do
    expect(example.level).to eq(::Logger::Severity::DEBUG)
  end

  it "should instantiate with a formatter" do
    source_location = example.formatter.source_location.first
    expect(source_location).to match(%r{multi_logger/formatter})
  end

  it "should write to a file" do
    expect(example.instance_variable_get("@logdev")).to respond_to(:filename)
  end
end
