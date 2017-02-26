require 'requests_helper'

describe 'options request to generic route' do

  before { options '/path' }

  it 'responds with 204' do
    assert_equal 204, last_response.status
  end

  it 'returns an empty body' do
    assert_empty last_response.body
  end

  it 'returns the allowed origins (CORS)' do
    assert_equal 'http://localhost',
      last_response.headers['Access-Control-Allow-Origin']
  end

  it 'returns the allowed HTTP methods (CORS)' do
    assert_includes %w(GET POST PUT PATCH OPTIONS DELETE).join(','),
      last_response.headers['Access-Control-Allow-Methods']
  end

  it 'returns the allowed headers (CORS)' do
    assert_includes %w(Content-Type Accept Auth-Token).join(','),
      last_response.headers['Access-Control-Allow-Headers']
  end
end
