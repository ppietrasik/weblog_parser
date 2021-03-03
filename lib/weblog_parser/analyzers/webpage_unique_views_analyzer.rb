# frozen_string_literal: true

require_relative '../webpage_unique_views'

module WeblogParser
    module Analyzers
        module WebpageUniqueViewsAnalyzer
            def self.call(log_entries)
                log_entries
                    .group_by(&:webpage)
                    .transform_values(&by_uniq_ip)
                    .transform_values(&:count)
                    .map { |webpage, unique_views_count| WebpageUniqueViews.new(webpage, unique_views_count) }
            end

            private

            def self.by_uniq_ip
                ->(entries) { entries.uniq(&:ip) }
            end
        end
    end
end
