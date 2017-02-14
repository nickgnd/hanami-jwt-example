module Web
  module Controllers
    module Authentication
      module Skip
        private

        def authenticate!
        end
      end

      def self.included(action)
        action.class_eval do
          before :authenticate!
        end
      end

      def initialize(authenticator: nil, **args)
        @authenticator = authenticator

        if args.any?
          super(**args)
        else
          super()
        end
      end

      private

      def authenticate!
        authenticator.authenticate!
      end

      def authenticator
        @authenticator || request.env['warden']
      end
    end
  end
end
