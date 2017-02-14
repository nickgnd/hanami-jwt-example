# Service to encode information (return jwt) and decode jwt

# Note:
# - The `secret key` is the same for every user:
# | - It doesn't run query against DB for every request to fetch custom `secret key`
# | - Is impossibile to invalidate jwt for a single user


# JSON Web Token defines some reserved claim names and defines how they should be used. JWT supports these reserved claim names:
# https://github.com/jwt/ruby-jwt
#
# 'exp' (Expiration Time) Claim
# 'nbf' (Not Before Time) Claim
# 'iss' (Issuer) Claim
# 'aud' (Audience) Claim
# 'jti' (JWT ID) Claim
# 'iat' (Issued At) Claim
# 'sub' (Subject) Claim


# TODO: extract in two separated Interactors?

class JwtIssuer
  DEFAULT_EXPIRE_TIME = 86400 # 24 hours

  class << self

    def encode(payload, exp = Time.new + DEFAULT_EXPIRE_TIME)
      payload[:exp] = exp.to_i
      JWT.encode(payload, secret_jwt_base)
    end

    def decode(token)
      body = JWT.decode(token, secret_jwt_base).first
    rescue
      # we don't need to trow errors, just return nil if JWT is invalid or expired
      nil
    end

    def secret_jwt_base
      @secret_key ||= begin
        secret_key = ENV['SECRET_JWT_KEY']
        raise ArgumentError,
          "Missing secret jwt base for #{ENV['HANAMI_ENV']} environment, set this value in .env file" unless secret_key

        secret_key
      end
    end
  end

  private_class_method :secret_jwt_base
end
