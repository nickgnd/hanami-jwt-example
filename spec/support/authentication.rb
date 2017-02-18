# Helper to mock authentication flow

module Spec
  module Support
    module Authentication
      private

      class Authenticator
        def authenticate!
        end
      end

      def authenticator
        @authenticator ||= Authenticator.new
      end
    end
  end
end
