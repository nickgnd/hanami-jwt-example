module Web
  module Controllers
    module Sessions
      class Create
        include Web::Action
        include Authentication::Skip
        include PasswordHelper
        include JwtHelper

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
            jwt = generate_jwt(user.id)
            status 201, JSON.generate({ auth_token: jwt })
          else
            status 401, 'Authentication failure'
          end
        end
      end
    end
  end
end
