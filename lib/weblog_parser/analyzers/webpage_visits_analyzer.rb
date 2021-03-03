# frozen_string_literal: true

require_relative '../webpage_visits'

module WeblogParser
    module Analyzers
        module WebpageVisitsAnalyzer
            def self.call(log_entries)
                log_entries
                    .group_by(&:webpage)
                    .transform_values(&:count)
                    .map { |webpage, visits_count| WebpageVisits.new(webpage, visits_count) }
            end
        end
    end
end
