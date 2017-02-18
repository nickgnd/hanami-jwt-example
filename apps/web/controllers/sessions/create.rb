require 'bcrypt'

# TODO: clean

module Web
  module Controllers
    module Sessions
      class Create
        include Web::Action
        include Authentication::Skip

        expose :jwt

        params do
          required(:user).schema do
            required(:email).filled(:str?, format?: /@/)
            required(:password).filled(:str?)
          end
        end

        def call(params)
          halt 401 unless params.valid?
          email = params.get(:user, :email)
          password = params.get(:user, :password)

          user = UserRepository.new.by_email(email)

          if user && check_password(user.password_digest, password)
            @jwt = set_jwt(user)
          else
            status 401, 'Authentication failure'
          end
        end

        private

        def check_password(password_digest, unencrypted_password)
          BCrypt::Password.new(password_digest).is_password?(unencrypted_password) && true
        end

        def set_jwt(user)
          payload = { user_id: user.id, iss: 'http://example.com' }
          JwtIssuer.encode(payload)
        end
      end
    end
  end
end
