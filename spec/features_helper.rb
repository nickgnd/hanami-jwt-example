# Require this file for feature tests
require_relative './spec_helper'
require 'rack/test'

class MiniTest::Spec
  include Rack::Test::Methods

  def app
    Hanami.app
  end
end
