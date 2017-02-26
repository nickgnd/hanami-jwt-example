class CorsSettings
  CORS_ALLOW_ORIGIN  = ENV['CORS_ALLOW_ORIGIN']
  CORS_ALLOW_METHODS = %w{GET POST PUT PATCH OPTIONS DELETE}.join(',')
  CORS_ALLOW_HEADERS = %w{Content-Type Accept Auth-Token}.join(',')
end
