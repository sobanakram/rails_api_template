source 'https://rubygems.org'
ruby '2.6.4'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.0'

gem 'active_storage_base64', '~> 1.0.0'
gem 'activeadmin', '~> 2.2'
gem 'active_model_serializers', '~> 0.10.0'
gem 'apipie-rails'
gem 'aws-sdk-s3', '~> 1', require: false
gem 'bootsnap', '~> 1.3.0'
gem 'devise', '~> 4.7.1'
gem 'devise_token_auth', '~> 1.1.2'
gem 'jbuilder', '~> 2.9.1'
# Use mysql as the database for Active Record
gem 'mysql2'
gem 'oj', '~> 3.7', '>= 3.7.12'
gem 'webpacker', '~> 4.0'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
gem 'image_processing', '~> 1.2'

group :development, :test do
  # Use Puma for development and test
  gem 'puma'
  gem 'bullet', '~> 6.0.2'
  gem 'factory_bot_rails', '~> 4.8.2'
  gem 'rspec-rails', '~> 3.8.2'
end

group :development do
  gem 'byebug'
  gem 'annotate', '~> 2.6.5'
  gem 'better_errors', '~> 2.1.1'
  gem 'binding_of_caller'
  gem 'brakeman', '~> 4.4.0'
  gem 'letter_opener', '~> 1.4.1'
  gem 'listen', '~> 3.0.5'
  gem 'rails_best_practices', '~> 1.19.4'
  gem 'reek', '~> 5.3.1'
  gem 'rubocop-rails', '~> 2.3'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.1'

  # For deployment
  gem "capistrano", "~> 3.11", require: false
  gem "capistrano-rails", "~> 1.4", require: false
  gem 'capistrano-passenger', '~> 0.2.0', require: false
  gem 'capistrano-rails-console', require: false
end

group :test do
  gem 'faker', '~> 1.7.3'
  gem 'shoulda-matchers', '~> 3.1.1'
  gem 'simplecov', '~> 0.13.0', require: false
  gem 'webmock', '~> 2.3.2'
end

group :assets do
  gem 'uglifier', '~> 2.7.2'
end

group :production do
  # Use Passenger for production
  gem "passenger", ">= 5.3.2", require: "phusion_passenger/rack_handler"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]