# Define constants here and require this file in the install script

# Deploy config file

# print "Deploy config (default: deploy): "
# deploy_file = gets.chomp
# DEPLOY_FILE = deploy_file.blank? ? 'deploy' : deploy_file

DEPLOY_FILE = 'deploy'

puts DEPLOY_FILE

# Application name/directory/etc.
APP_NAME = "cbsite"

# SSH key files
MY_PUBLIC_KEY = "/Users/curt/.ssh/id_rsa.pub"
DEPLOY_PUBLIC_KEY = "/Users/curt/.ssh/id_rsa_curt_github.pub"
DEPLOY_PRIVATE_KEY = "/Users/curt/.ssh/id_rsa_curt_github"

# Web app directory location
APPS_DIRECTORY = "/var/www/apps"

# Passenger settings
# PASSENGER_VERSION = "3.0.19"
PASSENGER_VERSION = "4.0.60"

# Additional apache config file - the conf.d directory is Included from the /etc/apache2/apache.conf
# MY_APACHE_CONFIG = "/etc/apache2/conf.d/additional_#{APP_NAME}_config"

MY_APACHE_CONFIG_FILENAME = "additional_#{APP_NAME}_config"
MY_APACHE_CONFIG = "/etc/apache2/conf-available/#{MY_APACHE_CONFIG_FILENAME}.conf"

# MySQL database user and pw
# print "MySQL user name: "
MYSQL_USER = 'megaman'
# print "MySQL password for #{MYSQL_USER}: "
MYSQL_PW = 'quack2tastic'

# Git repo domains - for getting public keys
GIT_REPO_DOMAINS = ['github.com', 'cbeery.unfuddle.com']