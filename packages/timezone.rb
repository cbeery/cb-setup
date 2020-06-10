package :timezone do
  tz_file = '/etc/timezone'

  noop do
    # pre :install, 'echo "America/Denver" | sudo tee /etc/timezone'

    # https://serverfault.com/questions/84521/automate-dpkg-reconfigure-tzdata/84528#comment1017649_84528
    pre :install, 'ln -fs /usr/share/zoneinfo/America/Denver /etc/localtime'
    pre :install, 'dpkg-reconfigure --frontend noninteractive tzdata'

    # pre :install, 'stop cron'
    # pre :install, 'start cron'
    # https://www.cyberciti.biz/faq/howto-linux-unix-start-restart-cron/
    pre :install, '/etc/init.d/cron stop'
    pre :install, '/etc/init.d/cron start'
  end

  verify do
    file_contains tz_file, 'America/Denver'
  end

end