require 'spec_helper'
require 'minitest/mock'
require 'bcrypt'

describe AuthenticationJwtStrategy do

  let(:password_digest) { BCrypt::Password.create('secret', cost: 1) }
  let(:user) { UserRepository.new.create(email: 'test@email.com', password_digest: password_digest) }
  let(:jwt) { JwtIssuer.encode({ user_id: user.id }) }

  after do
    UserRepository.new.clear
  end

  it '.valid? returns true with valid header attributes' do
    obj = ::AuthenticationJwtStrategy.new(nil)
    env = { 'HTTP_AUTHORIZATION' => "Bearer #{jwt}" }

    obj.stub :env, env do
      assert obj.valid?
    end
  end

  it '.valid? returns false with invalid header attributes' do
    obj = ::AuthenticationJwtStrategy.new(nil)
    env = {}

    obj.stub :env, env do
      refute obj.valid?
    end
  end

  it '.valid? returns false with invalid header jwt' do
    obj = ::AuthenticationJwtStrategy.new(nil)
    env = { 'HTTP_AUTHORIZATION' => nil }

    obj.stub :env, env do
      refute obj.valid?
    end
  end

  it '.authenticate! returns success with valid jwt' do
    obj = ::AuthenticationJwtStrategy.new(nil)
    env = { 'HTTP_AUTHORIZATION' => "Bearer #{jwt}" }

    obj.stub :env, env do
      assert_equal :success, obj.authenticate!
    end
  end

  it '.authenticate! returns fail with invalid header attributes' do
    obj = ::AuthenticationJwtStrategy.new(nil)
    env = { 'HTTP_AUTHORIZATION' => 'Bearer invalid_jwt1232131' }

    obj.stub :env, env do
      assert_equal :failure, obj.authenticate!
    end
  end

  it '.authenticate! returns fail with invalid payload information (user_id)' do
    obj = ::AuthenticationJwtStrategy.new(nil)
    wrong_jwt = JwtIssuer.encode({ user_id: 0 })
    env = { 'HTTP_AUTHORIZATION' => "Bearer #{wrong_jwt}" }


    obj.stub :env, env do
      assert_equal :failure, obj.authenticate!
    end
  end
end
