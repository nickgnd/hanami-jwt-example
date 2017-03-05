require 'hanami/interactor'

class UserRegister
  include Hanami::Interactor

  expose :user

  # @param user_attributes <Object> user params from registration request ({ email:, password: , password_confirmation: })
  #
  def initialize(user_attributes, password_service: nil, user_repository: nil)
    @user_attributes = user_attributes
    @password_service = password_service || ::Password
    @user_repository = user_repository || ::UserRepository
  end


  # Encrypt the password and transform the hash for persisting it
  #
  # @return <Object> { email:, password_digest: }
  #
  def call
    safe_user = @password_service.encrypt(user_attributes)
    @user = @user_repository.new.create(safe_user)
  end

  private

  attr_reader :user_attributes
end
