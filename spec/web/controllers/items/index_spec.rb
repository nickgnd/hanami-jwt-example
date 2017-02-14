require 'spec_helper'
require_relative '../../../../apps/web/controllers/items/index'

describe Web::Controllers::Items::Index do
  let(:action) { Web::Controllers::Items::Index.new }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 200
  end
end
