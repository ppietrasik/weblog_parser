# frozen_string_literal: true

require_relative './analyzers/webpage_visits_analyzer'
require_relative './analyzers/webpage_unique_views_analyzer'

module WeblogParser
    class LogsReport
        def initialize(log_entries)
            @log_entries = log_entries
        end

        def present
            <<~REPORT
            *** List of webpages visits ***
            #{format_results(webpage_visits)}

            *** List of webpages unique views ***
            #{format_results(webpage_unique_views)}
            REPORT
        end

        private

        attr_reader :log_entries

        def webpage_visits
            Analyzers::WebpageVisitsAnalyzer.call(log_entries).sort.reverse
        end

        def webpage_unique_views
            Analyzers::WebpageUniqueViewsAnalyzer.call(log_entries).sort.reverse
        end

        def format_results(results)
            results.map(&:to_s).join("\n")
        end
    end
end
