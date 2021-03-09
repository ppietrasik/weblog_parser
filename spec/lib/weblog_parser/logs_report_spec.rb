RSpec.describe WeblogParser::LogsReport do
  subject(:class_instance) { described_class.new(log_entries) }

  describe '#present' do
    subject(:method_call) { class_instance.present }

    let(:log_entries) do
      [
        WeblogParser::LogEntry.new('/index', '22.222.222.22'),
        WeblogParser::LogEntry.new('/index', '11.111.111.11'),
        WeblogParser::LogEntry.new('/contact', '11.111.111.11'),
        WeblogParser::LogEntry.new('/contact', '11.111.111.11'),
        WeblogParser::LogEntry.new('/contact', '11.111.111.11')
      ]
    end

    it 'returns correct output' do
      expect(WeblogParser::VisitsCount).to receive(:from_log_entries).with(log_entries).and_call_original
      expect(WeblogParser::UniqueViewsCount).to receive(:from_log_entries).with(log_entries).and_call_original

      expect(method_call).to eq(
        <<~OUTPUT
          *** List of webpages visits ***
          /contact 3 visits
          /index 2 visits

          *** List of webpages unique views ***
          /index 2 unique views
          /contact 1 unique views
        OUTPUT
      )
    end
  end
end
