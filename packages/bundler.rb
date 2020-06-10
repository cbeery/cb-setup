package :bundler do
  gem 'bundler'
  version '1.17.1'

  verify do
    has_executable 'bundle'
  end
end