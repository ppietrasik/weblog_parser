RSpec.describe WeblogParser::WebpageVisits do
    subject(:class_instance) { described_class.new(webpage, visits_count) }

    let(:webpage) { '/index' }
    let(:visits_count) { 2 }

    it { is_expected.to have_attributes(webpage: webpage, visits_count: visits_count) }

    describe '#to_s' do
        subject(:method_call) { class_instance.to_s }

        it { is_expected.to eq("#{webpage} #{visits_count} visits") }
    end

    describe '#<=>' do
        subject(:method_call) { class_instance.<=>(another_instance) }

        let(:another_instance) { described_class.new('/about', another_instance_visits_count) }

        context 'when another_instance_visits_count is equal' do
            let(:another_instance_visits_count) { visits_count }

            it { is_expected.to eq(0) }
        end

        context 'when another_instance_visits_count is larger' do
            let(:another_instance_visits_count) { 3 }

            it { is_expected.to eq(-1) }
        end

        context 'when another_instance_visits_count is lower' do
            let(:another_instance_visits_count) { 1 }

            it { is_expected.to eq(1) }
        end
    end
end
