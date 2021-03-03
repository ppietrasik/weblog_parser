require 'tempfile'

RSpec.describe WeblogParser::FileParser do
    subject(:class_instance) { described_class.new(file_path) }

    describe '#call' do
        subject(:method_call) { class_instance.call }

        context 'with existing log file' do
            let(:file_path) { file.path }
            let(:file) { Tempfile.new }

            before do
                file.write(logs)
                file.close
            end

            after { file.unlink }

            context 'with valid logs format' do
                let(:logs) do
                    <<~LOGS
                    /help_page/1 126.318.035.038
                    /contact 184.123.665.067
                    /home 184.123.665.067
                    LOGS
                end

                it 'returns correct objects' do 
                    expect(method_call).to match(
                        [
                            an_object_having_attributes(webpage: '/help_page/1', ip: '126.318.035.038'),
                            an_object_having_attributes(webpage: '/contact', ip: '184.123.665.067'),
                            an_object_having_attributes(webpage: '/home', ip: '184.123.665.067')
                        ]
                    )
                end
            end

            context 'with valid logs format' do
                let(:logs) do
                    <<~LOGS
                    /help_page/1 126.318.035.038
                    /contact 184.123.665.
                    /home 184.123.665.067
                    LOGS
                end

                it { expect { method_call }.to raise_exception(WeblogParser::Errors::InvalidLogFormatError) }
            end
        end

        context 'with non-existing file' do
            let(:file_path) { '' }

            it { expect { method_call }.to raise_exception(WeblogParser::Errors::FileNotExistingError) }
        end
    end
end
