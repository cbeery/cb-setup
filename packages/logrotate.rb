package :logrotate do
  app_name = APP_NAME
  logrotate_file = "/etc/logrotate.d/#{app_name}"

  transfer "configs/logrotate", logrotate_file

  verify do
    file_contains logrotate_file, app_name
    file_contains logrotate_file, "rotate"
  end

end