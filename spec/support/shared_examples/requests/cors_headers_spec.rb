# Shared specs for testing CORS headers

module Spec
  module Support
    module SharedExamples
      module Requests
        module CorsHeadersSpec

          def self.included(base)
            describe 'CORS headers' do
              it 'sets the allowed origins' do
                assert_equal 'http://localhost',
                  last_response.headers.fetch('Access-Control-Allow-Origin')
              end

              it 'sets the allowed HTTP methods' do
                assert_includes %w(GET POST PUT PATCH OPTIONS DELETE).join(','),
                  last_response.headers.fetch('Access-Control-Allow-Methods')
              end

              it 'sets the allowed headers' do
                assert_includes %w(Content-Type Accept Auth-Token).join(','),
                  last_response.headers.fetch('Access-Control-Allow-Headers')
              end
            end
          end

        end
      end
    end
  end
end
