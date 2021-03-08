# frozen_string_literal: true

module WeblogParser
    class UniqueViewsCount
        def self.from_log_entries(log_entries)
            log_entries
                .group_by(&:webpage)
                .transform_values(&by_uniq_ip)
                .transform_values(&:count)
                .map { |webpage, unique_views| new(webpage, unique_views) }
        end

        def initialize(webpage, unique_views)
            @webpage = webpage
            @unique_views = unique_views
        end

        attr_reader :webpage, :unique_views

        def to_s
            "#{webpage} #{unique_views} unique views"
        end

        def <=>(other)
            unique_views <=> other.unique_views
        end

        private

        def self.by_uniq_ip
            ->(entries) { entries.uniq(&:ip) }
        end
    end
end
