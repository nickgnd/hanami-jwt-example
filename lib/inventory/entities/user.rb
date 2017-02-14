# Basic solution to initialize a user with the digest_password
#
# User.new(email: 'me@email.com', password: 'secret')
# #<User:0x007fd21ae548b0 @attributes={:email=>"me@email.com", :password_digest=>"$2a$10$mm3hAa1p/Xnj7SEtRu3y/epSfqht.nBHtqP57G4.EnvI2aVHg73Z6"}>
#

# TODO: extract password hashing in ad hoc service

require 'bcrypt'

class User < Hanami::Entity
  include BCrypt

  def initialize(attributes = {})
    super attributes.merge(
      password_digest: BCrypt::Password.create(attributes[:password])
    )
  end

  def password
    BCrypt::Password.new(password_digest)
  end
end
