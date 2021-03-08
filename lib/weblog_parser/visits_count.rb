# frozen_string_literal: true

module WeblogParser
    class VisitsCount
        def self.from_log_entries(log_entries)
            log_entries
                .group_by(&:webpage)
                .transform_values(&:count)
                .map { |webpage, visits| new(webpage, visits) }
        end

        def initialize(webpage, visits)
            @webpage = webpage
            @visits = visits
        end

        attr_reader :webpage, :visits

        def to_s
            "#{webpage} #{visits} visits"
        end

        def <=>(other)
            visits <=> other.visits
        end
    end
end
