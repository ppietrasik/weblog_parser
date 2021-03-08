RSpec.describe WeblogParser::UniqueViewsCount do
    subject(:class_instance) { described_class.new(webpage, unique_views) }

    let(:webpage) { '/index' }
    let(:unique_views) { 2 }

    it { is_expected.to have_attributes(webpage: webpage, unique_views: unique_views) }

    describe '#to_s' do
        subject(:method_call) { class_instance.to_s }

        it { is_expected.to eq("#{webpage} #{unique_views} unique views") }
    end

    describe '#<=>' do
        subject(:method_call) { class_instance.<=>(another_instance) }

        let(:another_instance) { described_class.new('/about', another_instance_unique_views) }

        context 'when another_instance_unique_views is equal' do
            let(:another_instance_unique_views) { unique_views }

            it { is_expected.to eq(0) }
        end

        context 'when another_instance_unique_views is larger' do
            let(:another_instance_unique_views) { 3 }

            it { is_expected.to eq(-1) }
        end

        context 'when another_instance_unique_views is lower' do
            let(:another_instance_unique_views) { 1 }

            it { is_expected.to eq(1) }
        end
    end

    describe '.from_log_entries' do
        subject(:method_call) { described_class.from_log_entries(log_entries) }

        let(:log_entries) { [log_entry_1, log_entry_2, log_entry_3, log_entry_4] }

        let(:log_entry_1) { WeblogParser::LogEntry.new('/index', '22.222.222.22') }
        let(:log_entry_2) { WeblogParser::LogEntry.new('/about', '22.222.222.22') }
        let(:log_entry_3) { WeblogParser::LogEntry.new('/index', '11.111.111.11') }
        let(:log_entry_4) { WeblogParser::LogEntry.new('/about', '22.222.222.22') }

        it 'returns correct objects' do
            expect(method_call).to match(
                [
                    an_object_having_attributes(webpage: '/index', unique_views: 2),
                    an_object_having_attributes(webpage: '/about', unique_views: 1)
                ]
            )
        end

        context 'with more unique ip entries for different webpage' do
            let(:log_entry_3) { WeblogParser::LogEntry.new('/about', '11.111.111.11') }

            it 'returns correct objects' do
                expect(method_call).to match(
                    [
                        an_object_having_attributes(webpage: '/index', unique_views: 1),
                        an_object_having_attributes(webpage: '/about', unique_views: 2)
                    ]
                )
            end
        end
    end
end
