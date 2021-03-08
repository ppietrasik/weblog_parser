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
end
