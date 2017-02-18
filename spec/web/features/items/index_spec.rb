require 'features_helper'

describe 'GET /items api' do

  before do
    @user = UserRepository.new.create({email: 'test@email.com', password_digest: 'not_safe'})
    ItemRepository.new.create(code: 'TEST', available: true)
  end

  after do
    UserRepository.new.clear
    ItemRepository.new.clear
  end

  describe 'with valid headers and jwt' do
    it 'respond with success and list all items' do
      jwt = create_jwt(@user)

      header 'Accept', 'application/json'
      header 'Content-Type', 'application/json'
      header 'Authorization', "Bearer #{jwt}"
      get '/items'
      assert last_response.ok?
      assert_equal 1, JSON.parse(last_response.body).size
    end
  end

  describe 'without valid jwt' do
    it 'respond with unauthorized' do
      header 'Accept', 'application/json'
      header 'Content-Type', 'application/json'
      header 'Authorization', "Bearer INVALID"
      get '/items'
      assert_equal 401, last_response.status
    end
  end

  private

  def create_jwt(user)
    ::JwtIssuer.encode({ user_id: user.id, iss: 'http://example.com' })
  end
end
