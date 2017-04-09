# TODO: extract user presenter

module Web::Controllers::Users
  class Registration
    include Web::Action
    include Web::Controllers::Authentication::Skip

    params do
      configure do
        def valid_format?(email)
          email =~ /@/
        end

        # TODO: extract an interactor
        def unique?(email)
          UserRepository.new.by_email(email).nil?
        end
      end

      required(:user).schema do
        required(:email) { filled? & str? & valid_format? & unique? }
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
      status 201, JSON.generate(presenter(result.user.to_h))
    end

    private

    def presenter(user_hash)
      user = user_hash.tap { |attributes| attributes.delete(:password_digest) }
      { user: user }
    end
  end
end
