require 'spec_helper'
require_relative '../../../../apps/web/controllers/users/registration'

class UserRegisterFake
  def initialize(*)
  end

  def call
    UserStruct.new({ user: { email: 'test@example.com', password_digest: '23lkmlkdsmal' }})
  end

  private

  UserStruct = Struct.new('User', :user)
end


describe Web::Controllers::Users::Registration do
  let(:action) { Web::Controllers::Users::Registration.new(interactor: UserRegisterFake) }
  let(:params) { {
    user: { email: 'test@example.com', password: 'secret', password_confirmation: 'secret' }}
  }

  describe 'with valid params' do
    it 'is successful' do
      response = action.call(params)
      response[0].must_equal 201
    end
  end

  describe 'with invalid params' do
    it 'it returns 422' do
      response = action.call({})
      response[0].must_equal 422
    end
  end
end
