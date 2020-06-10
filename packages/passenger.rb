package :passenger, :provides => :appserver do
  # https://www.phusionpassenger.com/library/install/apache/install/oss/bionic/
  requires :apache, :passenger_dependencies
  description 'Passenger for Apache'

  apt 'libapache2-mod-passenger' do
    post :install, 'sudo a2enmod passenger'
    post :install, 'sudo apache2ctl restart'
    post :install, 'sudo /usr/bin/passenger-config validate-install --auto --validate-apache2 > verify-passenger.txt'
  end

  verify do
    has_file "verify-passenger.txt"
    file_contains "verify-passenger.txt", 'Everything looks good.'
  end

end

package :passenger_dependencies do
  description "Pre-passenger installs"
  requires :pgp_key, :https_support_for_apt, :add_apt_repo
end

package :pgp_key do
  apt 'dirmngr gnupg' do
    post :install, 'sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7'
  end
end

package :https_support_for_apt do
  apt 'apt-transport-https ca-certificates'
end

package :add_apt_repo do
 noop do
    post :install, "sudo sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger bionic main > /etc/apt/sources.list.d/passenger.list'"
    post :install, "sudo apt-get update"
  end
end
