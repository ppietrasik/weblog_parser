# frozen_string_literal: true

require_relative 'errors'
require_relative 'log_entry'

module WeblogParser
    class FileParser
        LOG_FORMAT = %r(([\/\w*]+) (\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})).freeze
        
        private_constant :LOG_FORMAT

        def initialize(file_path)
            raise Errors::FileNotExistingError unless File.exist?(file_path)

            @file_path = file_path 
        end

        def call
            log_entries = []
            
            File.foreach(file_path) do |read_line|
                log_match = read_line.match(LOG_FORMAT)
                raise Errors::InvalidLogFormatError unless log_match

                webpage, ip = log_match.captures
                log_entries << LogEntry.new(webpage, ip)
            end

            log_entries
        end

        private

        attr_reader :file_path
    end
end
