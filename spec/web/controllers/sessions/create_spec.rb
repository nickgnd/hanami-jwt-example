require 'spec_helper'
require_relative '../../../../apps/web/controllers/sessions/create'

class FakeBcrypt
  class PasswordTruthy
    def initialize(_password_digest)
    end

    def ==(_unencrypted_password)
      true
    end
  end

  class PasswordFalsy
    def initialize(_password_digest)
    end

    def ==(_unencrypted_password)
      false
    end
  end
end

class FakeJwtIssuer
  def self.encode(_user_id)
    '12345678'
  end
end

describe Web::Controllers::Sessions::Create do

  let(:params) { { user: { email: 'test@example.com', password: 'secret' }} }

  before do
    user = User.new(email: 'test@example.com', password_digest: 'password_digest')
    UserRepository.new.create(user)
  end

  after do
    UserRepository.new.clear
  end

  describe 'with valid credentials' do

    let(:action) { Web::Controllers::Sessions::Create.new(
      crypt_service: FakeBcrypt::PasswordTruthy,
      jwt_issuer_service: FakeJwtIssuer
    )}

    it 'is successful' do
      response = action.call(params)
      response[0].must_equal 201
    end
  end

  describe 'with missing params' do

    let(:action) { Web::Controllers::Sessions::Create.new(
      crypt_service: FakeBcrypt::PasswordTruthy,
      jwt_issuer_service: FakeJwtIssuer
    )}

    it 'returns unauthorized' do
      response = action.call(params.merge(user: {}))
      response[0].must_equal 401
    end
  end

  describe 'with invalid credentials' do

    let(:action) { Web::Controllers::Sessions::Create.new(
      crypt_service: FakeBcrypt::PasswordFalsy,
      jwt_issuer_service: FakeJwtIssuer
    )}

    it 'returns unauthorized' do
      response = action.call(params)
      response[0].must_equal 401
    end
  end
end
