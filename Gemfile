source 'http://rubygems.org'

gem 'rails', '3.2.12'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'
group :development, :test do
  gem 'sqlite3'
end

gem 'json'

gem 'table_for_collection'

gem 'anjlab-bootstrap-rails', :require => 'bootstrap-rails',
                          :github => 'anjlab/bootstrap-rails'
gem 'simple_form'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

# gem 'jquery-rails'

# gem 'bcrypt-ruby', :require => 'bcrypt' 
gem 'debugger', group: [:development, :test]

group :production, :staging do
  gem "pg"
end

gem 'rest-client', :require => 'rest-client'
gem  'multimap'




# To use ActiveModel has_secure_password
 gem 'bcrypt-ruby', '~> 3.0.0'
# gem 'bcrypt-ruby'
# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug'
#
# Rails ERD for diagrams
gem 'rails-erd'

gem 'quiet_assets', group: [:development, :production]
