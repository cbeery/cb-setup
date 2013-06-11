# Install script for ____
require './config.rb'
Dir.glob(File.join(File.dirname(__FILE__), 'packages/*.rb')).each { |f| require f }

policy :stack, :roles => :app do
  requires :build_essential
  requires :goodies
  # requires :goodies_test
  requires :timezone
  requires :root                    
  requires :deploy
  requires :ruby
  requires :bundler
  requires :scm # Git
  requires :capistrano_dirs
  requires :webserver # Apache
  requires :appserver # Passenger
  requires :database # MySQL
  requires :imagemagick
  requires :logrotate
end

deployment do
  # mechanism for deployment
  delivery :capistrano do
    recipes "deploy/#{DEPLOY_FILE}"
  end

  # source based package installer defaults
  source do
    prefix   '/usr/local'
    archives '/usr/local/sources'
    builds   '/usr/local/build'
  end
end

# Depend on a specific version of sprinkle 
begin
  gem 'sprinkle', "0.4.2" 
rescue Gem::LoadError
  puts "sprinkle 0.4.2 required.\n Run: `sudo gem install sprinkle`"
  exit
end