# Define authentication token strategy used by Warden Middleware

class AuthenticationJwtStrategy < ::Warden::Strategies::Base

  def valid?
    !!auth_token_from_headers
  end

  def authenticate!
    claims = decoded_token
    if claims && user = ::UserRepository.new.find(claims.fetch('user_id'))
      success!(user)
    else
      fail!
    end
  end

  # Warden checks this to see if the strategy should result in a permanent login
  #
  def store?
    false
  end

  private

  def decoded_token
    token = auth_token_from_headers&.split(' ')&.last # => fetch token: Authorization: 'Bearer <TOKEN>'
    token && ::JwtIssuer.decode(token)
  end

  def auth_token_from_headers
    env['HTTP_AUTHORIZATION']
  end
end

# Registry warden strategy
Warden::Strategies.add(:authentication_token, AuthenticationJwtStrategy)
