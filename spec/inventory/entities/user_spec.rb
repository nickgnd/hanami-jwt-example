require 'spec_helper'

describe User do

  let(:plain_attributes) { { email: 'nick@example.com', password: 's3cr3t' } }
  let(:attributes) { Password.encrypt(plain_attributes) }

  it 'can be initialised with email and password' do
    user = User.new(attributes)
    user.email.must_equal 'nick@example.com'
  end

  it '.password returns the encrypted value' do
    user = User.new(attributes)
    user.password.wont_equal 's3cr3t'
  end
end
