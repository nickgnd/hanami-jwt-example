require 'spec_helper'

describe Password do
  let(:user_attributes) {
    { email: 'nick@example.com', password: 'secret', password_digest: 'secret' }
  }

  let(:safe_user) { Password.encrypt(user_attributes) }

  it '.encrypt returns an object with email field not edited' do
    assert_equal user_attributes.fetch(:email), safe_user.fetch(:email, nil)
  end

  it '.encrypt returns an object with encrypted password' do
    refute_nil safe_user.fetch(:password_digest, nil)
    refute_equal user_attributes.fetch(:password), safe_user.fetch(:password_digest, nil)
  end

  it '.encrypt rejects password field' do
    refute safe_user.keys.include? :password
  end

  it '.encrypt rejects password_confirmation field' do
    refute safe_user.keys.include? :password_confirmation
  end

  it '.== returns true if the plain password matches the encrypted one' do
    encrypted_pwd = safe_user.fetch(:password_digest)

    assert Password.new(encrypted_pwd) == 'secret'
  end


  it '.== returns false if the plain password doesn\'t match the encrypted one' do
    encrypted_pwd = safe_user.fetch(:password_digest)

    refute Password.new(encrypted_pwd) == 'not_the_real_pwd'
  end

  it '.cost_factor returns 1 when in test environment' do
    assert_equal 1, Password.cost_factor
  end
end
