require 'spec_helper'

describe UserRegister do

  let(:user_attributes) { { email: 'nicolo@example.com', password: 'secret'} }
  let(:interactor) { UserRegister.new(user_attributes) }

  after do
    UserRepository.new.clear
  end

  it '.call encrypt the password and persist the user in db' do
    user = interactor.call.user

    refute_nil UserRepository.new.find user.id
  end
end
