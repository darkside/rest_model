module Transcriber
  class Resource
    module Response
      extend ActiveSupport::Concern

      def resource(options = {})
        root = options.fetch(:root, true)
        {}.tap do |resource|
          resource_keys(options).inject(resource) {|buffer, key| buffer.merge!(key.to_resource(self))}
          resource.merge!({link: link}) if root and self.class.relations.any?
        end
      end

      def link
        self.class.relations.map {|key| key.to_relation(self)}
      end

      def resource_keys(options)
        return self.class.summarized_keys if options[:summarize] and self.class.summarized_keys.any?
        self.class.keys
      end

      module ClassMethods
        def normalize(model, options = {})
          model.kind_of?(Enumerable) ?
            {entries: model.map {|m| m.resource(options.merge(summarize: true))}}
           : model.resource(options)
        end

        alias :resources :normalize

        def transcribe(input, options = {})
          normalize(parse(input, options), options)
        end
      end
    end
  end
end
