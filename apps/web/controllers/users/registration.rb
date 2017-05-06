# TODO: return a valuable error message when user registration fails
# TODO: extract user presenter

module Web::Controllers::Users
  class Registration
    include Web::Action
    include Web::Controllers::Authentication::Skip

    params do
      required(:user).schema do
        required(:email).filled(:str?, format?: /@/)
        required(:password).filled(:str?).confirmation
      end
    end

    def initialize(interactor: UserRegister, **args)
      @interactor = interactor
      super(**args)
    end


    def call(params)
      halt 422 unless params.valid?

      result = @interactor.new(params.get(:user)).call
      if result.successful?
        status 201, JSON.generate(presenter(result.user.to_h))
      else
        halt 422
      end
    end

    private

    def presenter(user_hash)
      user = user_hash.tap { |attributes| attributes.delete(:password_digest) }
      { user: user }
    end
  end
end
