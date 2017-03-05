# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
get '/items', to: 'items#index'

post '/sessions', to: 'sessions#create'

post '/registration', to: 'users#registration'

# CORS
#
cors_handler = ->(env) {
  [
    204,
    {
      'Access-Control-Allow-Origin'  => CorsSettings::CORS_ALLOW_ORIGIN,
      'Access-Control-Allow-Methods' => CorsSettings::CORS_ALLOW_METHODS,
      'Access-Control-Allow-Headers' => CorsSettings::CORS_ALLOW_HEADERS
    },
    []
  ]
}

options '/*', to: cors_handler
