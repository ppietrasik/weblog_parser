RSpec.describe WeblogParser::LogEntry do
  subject(:class_instance) { described_class.new(webpage, ip) }

  let(:webpage) { '/index' }
  let(:ip) { '22.333.444.55' }

  it { is_expected.to have_attributes(webpage: webpage, ip: ip) }
end
