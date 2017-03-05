source 'https://rubygems.org'

gem 'rake'
gem 'hanami',       '1.0.0.beta1'
gem 'hanami-model', '~> 1.0.0.beta1'

# TODO: remove me at the next Hanami release
#
# Use the master branch of 'hanami-router' gem to fix issue with nested params
# https://github.com/hanami/controller/issues/214
#
gem 'hanami-router', git: 'https://github.com/hanami/router', branch: 'master'

gem 'pg'

gem 'jwt'
gem 'bcrypt', require: false
gem 'warden'

gem 'transproc'

group :development do
  # Code reloading
  # See: http://hanamirb.org/guides/projects/code-reloading
  gem 'shotgun'
end

group :test, :development do
  gem 'dotenv', '~> 2.0'
end

group :test do
  gem 'minitest'
  gem 'rack-test'
end

group :production do
  # gem 'puma'
end
