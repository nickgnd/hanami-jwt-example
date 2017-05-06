require 'spec_helper'
require_relative '../../../../apps/web/controllers/users/registration'

describe Web::Controllers::Users::Registration do
  let(:action) { Web::Controllers::Users::Registration.new }
  let(:params) { {
    user: { email: 'test@example.com', password: 'secret', password_confirmation: 'secret' }}
  }

  describe 'with invalid params' do
    it 'it returns 422' do
      response = action.call({})
      response[0].must_equal 422
    end
  end
end
