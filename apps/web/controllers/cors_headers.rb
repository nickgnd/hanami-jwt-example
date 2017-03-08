module Web
  module Controllers
    module CorsHeaders

      def self.included(action)
        action.class_eval do
          before :include_cors_headers
        end
      end

      def include_cors_headers
        self.headers.merge!(cors_headers) # <= need merge
      end

      private

      def cors_headers
        {
          'Access-Control-Allow-Origin'  => Settings::Cors::CORS_ALLOW_ORIGIN,
          'Access-Control-Allow-Methods' => Settings::Cors::CORS_ALLOW_METHODS,
          'Access-Control-Allow-Headers' => Settings::Cors::CORS_ALLOW_HEADERS
        }
      end
    end
  end
end
