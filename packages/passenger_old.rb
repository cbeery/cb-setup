package :passenger_old do
  requires :apache
  description 'Passenger (mod_rails) for Apache'
  version PASSENGER_VERSION
  gem 'passenger', :version => version do
    post :install, 'passenger-install-apache2-module --auto'
  end

  verify do
    has_gem  'passenger', version
    has_file "/usr/local/lib/ruby/gems/1.9.1/gems/passenger-#{version}/ext/apache2/mod_passenger.so"
  end

  optional :passenger_configuration
end

# Run the application server with this command:
#
#   touch tmp/restart.txt
#
package :passenger_configuration do
  description "Configure Passenger for Apache"
  requires :passenger_load_file, :passenger_conf_file
end

package :passenger_load_file do
  load_file = '/etc/apache2/mods-available/passenger.load'

  push_text File.read('configs/passenger/passenger.load'), load_file 

  verify do
    has_file      load_file
    file_contains load_file, 'LoadModule'
  end
end

package :passenger_conf_file do
  configuration_file = '/etc/apache2/mods-available/passenger.conf'
  
  push_text File.read('configs/passenger/passenger.conf'), configuration_file do
    post :install, 'a2enmod passenger'
  end

  verify do
    has_file configuration_file
    file_contains configuration_file, 'PassengerRoot'
  end
end
