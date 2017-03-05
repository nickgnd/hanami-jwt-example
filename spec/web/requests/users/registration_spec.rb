require 'requests_helper'
require_relative '../../../support/shared_examples/requests/cors_headers_spec'

describe 'POST /registration api' do

  let(:params) {
    { user: { email: 'test@email.com', password: 'secret', password_confirmation: 'secret' }}
  }

  describe 'with valid params' do
    include Spec::Support::SharedExamples::Requests::CorsHeadersSpec

    before do
      header 'Accept', 'application/json'
      header 'Content-Type', 'application/json'
      post '/registration', JSON.generate(params)
    end

    after do
      UserRepository.new.clear
    end

    it 'responds with 201' do
      assert_equal 201, last_response.status
    end

    it 'responds with user' do
      refute_nil JSON.parse(last_response.body).fetch('user', nil)
    end

    it 'filters password_digest field' do
      refute JSON.parse(last_response.body).fetch('user').keys.include? 'password_digest'
    end
  end

  describe 'with invalid params' do
    include Spec::Support::SharedExamples::Requests::CorsHeadersSpec

    before do
      header 'Accept', 'application/json'
      header 'Content-Type', 'application/json'
      post '/registration', JSON.generate({ user: {}})
    end

    it 'responds with 422' do
      assert_equal 422, last_response.status
    end
  end
end
