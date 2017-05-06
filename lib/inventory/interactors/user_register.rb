# Interactor responsabilities:
#
# - Check email uniqueness
# - Persist the user

require 'hanami/interactor'

class UserRegister
  include Hanami::Interactor

  expose :user

  # @param user_attributes [Hash] user params from registration request ({ email:, password: , password_confirmation: })
  #
  def initialize(user_attributes, password_service: nil, user_repository: nil)
    @user_attributes = user_attributes
    @password_service = password_service || ::Password
    @user_repository = user_repository || ::UserRepository.new
  end


  def call
    error!('The email is already taken') if email_already_registered?

    user_with_encrypted_password = @password_service.encrypt(user_attributes)
    @user = @user_repository.create(user_with_encrypted_password)
  end

  private

  def email_already_registered?
    email = user_attributes.fetch(:email)
    @user_repository.by_email(email) && true
  end

  attr_reader :user_attributes
end
