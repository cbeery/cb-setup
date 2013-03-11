package :bundler do
  gem 'bundler'
  version '1.2.1'

  verify do
    has_executable 'bundle'
  end
end