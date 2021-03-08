# frozen_string_literal: true

require_relative '../visits_count'

module WeblogParser
    module Analyzers
        module WebpageVisitsAnalyzer
            def self.call(log_entries)
                log_entries
                    .group_by(&:webpage)
                    .transform_values(&:count)
                    .map { |webpage, visits| VisitsCount.new(webpage, visits) }
            end
        end
    end
end
