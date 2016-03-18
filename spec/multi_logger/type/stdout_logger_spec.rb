describe MultiLogger::StdoutLogger do
  let(:example) { described_class.new(level: :debug) }

  it "should instantiate with a level" do
    expect(example.level).to eq(::Logger::Severity::DEBUG)
  end

  it "should instantiate with a formatter" do
    source_location = example.formatter.source_location.first
    expect(source_location).to match(%r{multi_logger/formatter})
  end

  it "should write to stdout" do
    expect(example.instance_variable_get("@logdev").dev).to eq($stdout)
  end
end
