# Step to save use with safe passwor through hanami console
#
# bundle exec hanami console
# require 'bcrypt'
# User.new(email: 'me@email.com', password_digest: BCrypt::Password.create('secret'))
# #<User:0x007fd21ae548b0 @attributes={:email=>"me@email.com", :password_digest=>"$2a$10$mm3hAa1p/Xnj7SEtRu3y/epSfqht.nBHtqP57G4.EnvI2aVHg73Z6"}>
#

# TODO: create password hashing service

class User < Hanami::Entity
end
