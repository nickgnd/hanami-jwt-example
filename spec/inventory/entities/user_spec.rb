require 'spec_helper'

describe User do
  it 'can be initialised with attributes' do
    user = User.new(email: 'nick@example.com')
    user.email.must_equal 'nick@example.com'
  end
end
