# require 'spec_helper'
# require_relative '../../../../apps/web/controllers/sessions/create'
# require_relative '../../../support/authentication'

# describe Web::Controllers::Sessions::Create do
#   include Spec::Support::Authentication

#   let(:action) { Web::Controllers::Sessions::Create.new(authenticator: authenticator) }
#   let(:params) { Hash[] }

#   it 'is successful' do
#     response = action.call(params)
#     response[0].must_equal 200
#   end
# end
