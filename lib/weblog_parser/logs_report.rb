# frozen_string_literal: true

require_relative './visits_count'
require_relative './unique_views_count'

module WeblogParser
    class LogsReport
        def initialize(log_entries)
            @log_entries = log_entries
        end

        def present
            <<~REPORT
            *** List of webpages visits ***
            #{format_results(visits_counts)}

            *** List of webpages unique views ***
            #{format_results(unique_views_counts)}
            REPORT
        end

        private

        attr_reader :log_entries

        def visits_counts
            VisitsCount.from_log_entries(log_entries).sort.reverse
        end

        def unique_views_counts
            UniqueViewsCount.from_log_entries(log_entries).sort.reverse
        end

        def format_results(results)
            results.map(&:to_s).join("\n")
        end
    end
end
