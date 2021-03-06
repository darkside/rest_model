class RestModel
  module Response
    extend ActiveSupport::Concern

    def resource(options = {})
      root = options.fetch(:root, true)

      {}.tap do |resource|
        resource_keys(options).inject(resource) do |buffer, key|
          buffer.merge!(key.to_resource(self))
        end

        if (links = build_links).any? && !options[:summarize]
          resource.merge!(link: links)
        end
      end
    end

    def build_links
      self.class.relations.map {|key| key.to_relation(self)}.compact
    end

    def resource_keys(options)
      summarize?(options) ? self.class.summarized_keys + [Href.new] : self.class.keys
    end

    def summarize?(options)
      options[:summarize] and self.class.summarized_keys.any?
    end

    module ClassMethods
      def normalize(model, options = {})
        model.kind_of?(Enumerable) ?
          {entries: model.map {|m| m.resource(options.merge(summarize: true))}}
         : model.resource(options)
      end

      alias :resources :normalize
    end
  end
end
