require 'requests_helper'
require 'bcrypt'
require_relative '../../../support/shared_examples/requests/cors_headers_spec'

describe 'POST /sessions api' do

  let(:password_digest) { BCrypt::Password.create('secret', cost: 1) }
  let(:user) { User.new(email: 'test@email.com', password_digest: password_digest) }

  before do
    UserRepository.new.create(user)
  end

  after do
    UserRepository.new.clear
  end

  describe 'with valid credentials' do
    include Spec::Support::SharedExamples::Requests::CorsHeadersSpec

    before do
      header 'Accept', 'application/json'
      header 'Content-Type', 'application/json'
      post '/sessions', JSON.generate({ user: { email: 'test@email.com', password: 'secret' }})
    end

    it 'responds with 201' do
      assert_equal 201, last_response.status
    end

    it 'responds with auth_token' do
      refute_nil JSON.parse(last_response.body).fetch('auth_token', nil)
    end
  end

  describe 'with invalid credentials' do
    include Spec::Support::SharedExamples::Requests::CorsHeadersSpec

    before do
      header 'Accept', 'application/json'
      header 'Content-Type', 'application/json'
      post '/sessions', JSON.generate({ user: { email: 'wrong_email@email.com', password: 'abc' }})
    end

    it 'responds with 401' do
      assert_equal 401, last_response.status
    end
  end
end
