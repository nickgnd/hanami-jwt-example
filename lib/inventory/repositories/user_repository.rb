class UserRepository < Hanami::Repository
  def by_email(email)
    users.where(email: email).as(:entity).one
  end
end
