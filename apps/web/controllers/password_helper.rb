module Web
  module Controllers
    module PasswordHelper

      def initialize(crypt_service: nil, **args)
        @crypt_service = crypt_service

        if args.any?
          super(**args)
        else
          super()
        end
      end

      def check_password(password_digest, unencrypted_password)
        crypt_service.new(password_digest) == unencrypted_password
      end

      def crypt_service
        @crypt_service || ::Password
      end
    end
  end
end
