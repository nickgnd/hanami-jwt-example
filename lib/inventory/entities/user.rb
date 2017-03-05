# Step to get user with safe password through hanami console
#
# bundle exec hanami console
#
# user_attributes = { email: 'me@email.com', password: 'secret' }
# user = User.new(Password.encrypt(user_attributes))
#
# #<User:0x007fd21ae548b0 @attributes={:email=>"me@email.com", :password_digest=>"$2a$10$mm3hAa1p/Xnj7SEtRu3y/epSfqht.nBHtqP57G4.EnvI2aVHg73Z6"}>
#
# user.password
# #<Password:0x007fd88d70b210 @password_digest="$2a$10$MbnLLD7NVsA.W8dVFddd6eZZKUS3jkmzf0BjaiqoW6mpvhOmG7l.i">

require_relative '../services/password'

class User < Hanami::Entity

  def password
    Password.new(password_digest)
  end
end
