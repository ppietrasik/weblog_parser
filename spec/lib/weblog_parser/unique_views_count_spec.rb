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
end
