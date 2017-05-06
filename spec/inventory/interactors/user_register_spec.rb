require 'spec_helper'

describe UserRegister do

  let(:user_attributes) { { email: 'nicolo@example.com', password: 'secret'} }

  after do
    UserRepository.new.clear
  end

  it 'halts the flow if the email provided is already taken' do
    UserRepository.new.create(email: 'nicolo@example.com', password_digest: 'digest_password_231312312')
    result = UserRegister.new(user_attributes).call

    refute result.successful?
  end

  it 'encrypts the password and persists the user in db' do
    result = UserRegister.new(user_attributes).call
    user = result.user

    refute_nil UserRepository.new.find(user.id)
  end
end
