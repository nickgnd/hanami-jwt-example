require 'spec_helper'

describe User do
  it 'can be initialised with attributes' do
    skip
    user = User.new(attributes)
    user.email.must_equal 'nick@example.com'
  end

  it '.password returns the encrypted value' do
    skip
    user = User.new(attributes)
    user.password.wont_equal 'plain_password'
  end

  private

  def attributes
    {
      email: 'nick@example.com',
      password: 's3cr3t'
    }
  end
end
