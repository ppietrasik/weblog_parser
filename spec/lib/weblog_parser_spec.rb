RSpec.describe WeblogParser do
    describe '.present' do
        subject(:method_call) { described_class.present(file_path) }

        let(:file_path) { 'spec/fixtures/webserver.log' }

        it 'returns correct output' do
            expect(method_call).to eq(
                <<~OUTPUT
                *** List of webpages visits ***
                /help_page/1 4 visits
                /home 2 visits
                /about 1 visits

                *** List of webpages unique views ***
                /help_page/1 4 unique views
                /home 2 unique views
                /about 1 unique views
                OUTPUT
            )
        end
    end
end
