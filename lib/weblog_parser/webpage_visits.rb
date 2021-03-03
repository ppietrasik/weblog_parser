# frozen_string_literal: true

module WeblogParser
    class WebpageVisits
        def initialize(webpage, visits_count)
            @webpage = webpage
            @visits_count = visits_count
        end

        attr_reader :webpage, :visits_count

        def to_s
            "#{webpage} #{visits_count} visits"
        end

        def <=>(other)
            visits_count <=> other.visits_count
        end
    end
end
