RSpec.describe WeblogParser::Analyzers::WebpageVisitsAnalyzer do
    describe '.call' do
        subject(:method_call) { described_class.call(log_entries) }

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
