module Locomotive
  module LiquidExtensions
    module Filters
      module Math

        def localized_utc_date(input, *args)
          return '' if input.blank?

          format, locale = args

          locale ||= I18n.locale
          format ||= I18n.t('date.formats.default', locale: locale)

          if input.is_a?(String)
            begin
              fragments = ::Date._strptime(input, format)
              input = ::Date.new(fragments[:year], fragments[:mon], fragments[:mday])
            rescue
              input = Time.parse(input)
            end
          end

          return input.to_s unless input.respond_to?(:strftime)

          input = input.in_time_zone("UTC") if input.respond_to?(:in_time_zone)

          I18n.l input, format: format, locale: locale
        end

        alias :format_utc_date :localized_utc_date
      end
    end
  end
end
