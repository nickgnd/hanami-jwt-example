require 'spec_helper'

describe Item do
  it 'can be initialised with attributes' do
    product = Item.new(code: 'JU89')
    product.code.must_equal 'JU89'
  end
end
