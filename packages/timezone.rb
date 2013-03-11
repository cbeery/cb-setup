package :timezone do
  tz_file = '/etc/timezone'

  noop do
    pre :install, 'echo "America/Denver" | sudo tee /etc/timezone'
    pre :install, 'dpkg-reconfigure --frontend noninteractive tzdata'
    pre :install, 'stop cron'
    pre :install, 'start cron'
  end

  verify do
    file_contains tz_file, 'America/Denver'
  end

end