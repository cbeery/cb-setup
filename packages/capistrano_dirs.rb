package :capistrano_dirs do
  noop do
    pre :install, "mkdir -p #{APPS_DIRECTORY}/#{APP_NAME}/releases/"
    pre :install, "mkdir -p #{APPS_DIRECTORY}/#{APP_NAME}/shared/"
    pre :install, "mkdir -p #{APPS_DIRECTORY}/#{APP_NAME}/shared/config"
    pre :install, "mkdir -p #{APPS_DIRECTORY}/#{APP_NAME}/shared/log"
    pre :install, "mkdir -p #{APPS_DIRECTORY}/#{APP_NAME}/shared/pids"
    pre :install, "mkdir -p #{APPS_DIRECTORY}/#{APP_NAME}/shared/system"
    pre :install, "mkdir -p #{APPS_DIRECTORY}/#{APP_NAME}/shared/assets"
    pre :install, "chown -R deploy:deploy #{APPS_DIRECTORY}/#{APP_NAME}/"
    pre :install, "chmod -R ug=rwx #{APPS_DIRECTORY}/#{APP_NAME}/"
  end

  verify do
    has_directory "#{APPS_DIRECTORY}/#{APP_NAME}/shared/assets"
  end

  requires :git
end