# frozen_string_literal: true

module WeblogParser
    class WebpageUniqueViews
        def initialize(webpage, unique_views_count)
            @webpage = webpage
            @unique_views_count = unique_views_count
        end

        attr_reader :webpage, :unique_views_count

        def to_s
            "#{webpage} #{unique_views_count} unique views"
        end

        def <=>(other)
            unique_views_count <=> other.unique_views_count
        end
    end
end
