RSpec.describe WeblogParser::WebpageUniqueViews do
    subject(:class_instance) { described_class.new(webpage, unique_views_count) }

    let(:webpage) { '/index' }
    let(:unique_views_count) { 2 }

    it { is_expected.to have_attributes(webpage: webpage, unique_views_count: unique_views_count) }

    describe '#to_s' do
        subject(:method_call) { class_instance.to_s }

        it { is_expected.to eq("#{webpage} #{unique_views_count} unique views") }
    end

    describe '#<=>' do
        subject(:method_call) { class_instance.<=>(another_instance) }

        let(:another_instance) { described_class.new('/about', another_instance_unique_views_count) }

        context 'when another_instance_unique_views_count is equal' do
            let(:another_instance_unique_views_count) { unique_views_count }

            it { is_expected.to eq(0) }
        end

        context 'when another_instance_unique_views_count is larger' do
            let(:another_instance_unique_views_count) { 3 }

            it { is_expected.to eq(-1) }
        end

        context 'when another_instance_unique_views_count is lower' do
            let(:another_instance_unique_views_count) { 1 }

            it { is_expected.to eq(1) }
        end
    end
end
