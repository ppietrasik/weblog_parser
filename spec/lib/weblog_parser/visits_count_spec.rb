RSpec.describe WeblogParser::VisitsCount do
  subject(:class_instance) { described_class.new(webpage, visits) }

  let(:webpage) { '/index' }
  let(:visits) { 2 }

  it { is_expected.to have_attributes(webpage: webpage, visits: visits) }

  describe '#to_s' do
    subject(:method_call) { class_instance.to_s }

    it { is_expected.to eq("#{webpage} #{visits} visits") }
  end

  describe '#<=>' do
    subject(:method_call) { class_instance.<=>(another_instance) }

    let(:another_instance) { described_class.new('/about', another_instance_visits) }

    context 'when another_instance_visits is equal' do
      let(:another_instance_visits) { visits }

      it { is_expected.to eq(0) }
    end

    context 'when another_instance_visits is larger' do
      let(:another_instance_visits) { 3 }

      it { is_expected.to eq(-1) }
    end

    context 'when another_instance_visits is lower' do
      let(:another_instance_visits) { 1 }

      it { is_expected.to eq(1) }
    end
  end

  describe '.from_log_entries' do
    subject(:method_call) { described_class.from_log_entries(log_entries) }

    let(:log_entries) { [log_entry_1, log_entry_2, log_entry_3] }

    let(:log_entry_1) { WeblogParser::LogEntry.new('/index', '22.222.222.22') }
    let(:log_entry_2) { WeblogParser::LogEntry.new('/about', '11.222.222.22') }
    let(:log_entry_3) { WeblogParser::LogEntry.new('/index', '22.222.222.22') }

    it 'returns correct objects' do
      expect(method_call).to match(
        [
          an_object_having_attributes(webpage: '/index', visits: 2),
          an_object_having_attributes(webpage: '/about', visits: 1)
        ]
      )
    end

    context 'with more entries for different webpage' do
      let(:log_entry_3) { WeblogParser::LogEntry.new('/about', '11.111.111.11') }

      it 'returns correct object' do
        expect(method_call).to match(
          [
            an_object_having_attributes(webpage: '/index', visits: 1),
            an_object_having_attributes(webpage: '/about', visits: 2)
          ]
        )
      end
    end
  end
end
