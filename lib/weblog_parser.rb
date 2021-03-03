# frozen_string_literal: true

require_relative './weblog_parser/file_parser'
require_relative './weblog_parser/logs_report'

module WeblogParser
    def self.present(file_path)
        log_entries = FileParser.new(file_path).call

        LogsReport.new(log_entries).present
    end
end
