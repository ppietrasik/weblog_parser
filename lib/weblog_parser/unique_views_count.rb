# frozen_string_literal: true

module WeblogParser
    class UniqueViewsCount
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
    end
end
