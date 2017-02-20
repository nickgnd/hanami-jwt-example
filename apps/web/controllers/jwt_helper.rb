module Web
  module Controllers
    module JwtHelper

      def initialize(jwt_issuer_service: nil, **args)
        @jwt_issuer_service = jwt_issuer_service

        if args.any?
          super(**args)
        else
          super()
        end
      end

      def generate_jwt(user_id)
        payload = { user_id: user_id, iss: 'http://inventory.com' }
        jwt_issuer_service.encode(payload)
      end

      def jwt_issuer_service
        @jwt_issuer_service || ::JwtIssuer
      end
    end
  end
end
