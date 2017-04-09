require 'spec_helper'

describe UserRepository do

  after do
    UserRepository.new.clear
  end

  it '.by_email returns the user that matches the email' do
    user = UserRepository.new.create(email: 'test@example.com', password_digest: '23lkmlkdsmal')

    assert_equal user, UserRepository.new.by_email('test@example.com')
  end
end
