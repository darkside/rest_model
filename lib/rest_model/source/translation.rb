class RestModel
  module Source
    class Translation
      attr_accessor :values, :from_source, :to_source

      def initialize(attrs = {})
        @values      = attrs[:values]
        @from_source = attrs[:from_source]
        @to_source   = attrs[:to_source]
      end

      def translates_from_source?
        from_source or values
      end

      def translate_from_source(value, resource)
        if from_source
          resource.instance_exec(value, &from_source)
        elsif values
          unless values.has_value?(value)
            fail TranslationError, "value '#{value}' doesn't belong to values: #{values.values}"
          end

          values.key(value)
        else
          value
        end
      end

      def translates_to_source?
        to_source or values
      end

      def translate_to_source(value, resource)
        if to_source
          resource.instance_exec(value, &to_source)
        elsif values
          unless values.has_key?(value)
            fail TranslationError, "value '#{value}' doesn't belong to values: #{values.keys}"
          end

          values[value]
        else
          value
        end
      end
    end
  end
end
