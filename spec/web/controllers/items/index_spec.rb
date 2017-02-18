require 'spec_helper'
require_relative '../../../../apps/web/controllers/items/index'
require_relative '../../../support/authentication'

describe Web::Controllers::Items::Index do
  include Spec::Support::Authentication

  let(:action) { Web::Controllers::Items::Index.new(authenticator: authenticator) }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 200
  end
end
