require 'spec_helper'

describe JwtIssuer do
  let(:payload) { { user_id: 1, iss: 'http://example.com' } }

  it '.encode returns a new jwt' do
    jwt = JwtIssuer.encode(payload)
    refute_nil jwt
  end

  it '.decode returns valid informations if the jwt is valid' do
    jwt = JwtIssuer.encode(payload)
    payload_decoded = JwtIssuer.decode(jwt)

    assert_equal(1, payload_decoded['user_id'])
    assert_equal('http://example.com', payload_decoded['iss'])
    refute_nil payload_decoded['exp']
  end

  it '.decode returns nil if jwt is not valid' do
    assert_nil JwtIssuer.decode('invalid token')
  end

  it '.decode returns nil if jwt is expired' do
    yesterday = Time.now - 86400
    expired_jwt = JwtIssuer.encode(payload, yesterday)
    assert_nil JwtIssuer.decode(expired_jwt)
  end
end
