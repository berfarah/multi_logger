describe MultiLogger::NullLogger do
  let(:example) { described_class.new(level: :debug) }

  it "should respond to log methods" do
    expect(example).to respond_to :debug, :info, :warn, :error, :fatal
  end
end
