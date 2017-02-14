require 'features_helper'

describe 'GET /items api' do

  before do
    ItemRepository.new.create(code: 'TEST', available: true)
  end

  after do
    ItemRepository.new.clear
  end

  it 'respond with success and list all items' do
    get '/items'
    assert last_response.ok?
    assert_equal 1, JSON.parse(last_response.body).size
  end
end
