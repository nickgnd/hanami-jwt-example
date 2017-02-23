require 'features_helper'
require 'bcrypt'

describe 'POST /sessions api' do

  before do
    password_digest = BCrypt::Password.create('secret', cost: 1)
    user = User.new(email: 'test@email.com', password_digest: password_digest)
    UserRepository.new.create(user)
  end

  after do
    UserRepository.new.clear
  end

  it 'responds with 201 with the right credentials' do
    header 'Accept', 'application/json'
    header 'Content-Type', 'application/json'
    post '/sessions', JSON.generate({ user: { email: 'test@email.com', password: 'secret' }})
    assert_equal 201, last_response.status
  end

  it 'responds with auth_token with the right credentials' do
    header 'Accept', 'application/json'
    header 'Content-Type', 'application/json'
    post '/sessions', JSON.generate({ user: { email: 'test@email.com', password: 'secret' }})
    refute_nil JSON.parse(last_response.body).fetch('auth_token', nil)
  end

  it 'responds with 401 status with wrong email' do
    header 'Accept', 'application/json'
    header 'Content-Type', 'application/json'
    post '/sessions', JSON.generate({ user: { email: 'wrong_email@email.com', password: 'secret' }})
    assert_equal 401, last_response.status
  end

  it 'responds with 401 status with wrong password' do
    header 'Accept', 'application/json'
    header 'Content-Type', 'application/json'
    post '/sessions', JSON.generate({ user: { email: 'test@email.com', password: 'wrong_password' }})
    assert_equal 401, last_response.status
  end

  it 'responds with 401 without required params' do
    header 'Accept', 'application/json'
    header 'Content-Type', 'application/json'
    post '/sessions', JSON.generate({ user: { password: 'secret' }})
    assert_equal 401, last_response.status
  end
end
