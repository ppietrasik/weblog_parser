# frozen_string_literal: true

module WeblogParser
    class VisitsCount
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
