# ip = ""

# ip = Capistrano::CLI.ui.ask "IP address: "
ip = '104.239.145.103'
set :host_address, ip

# setup_user = Capistrano::CLI.ui.ask "User for setup/config on #{host_address}: "
# setup_user_pw = Capistrano::CLI.ui.ask "Password for #{setup_user} on #{host_address}: "
setup_user = 'root'
setup_user_pw = 'TEHxH27GtdCiHYsBF7RceUPR'
set :user, setup_user
set :password, setup_user_pw

role :app, host_address
role :web, host_address
role :db,  host_address, :primary => true

set :use_sudo, false

# Fill options below if you wish to use public/private-key auth instead of password one
default_run_options[:pty] = true
#ssh_options[:user] = "root"
#ssh_options[:keys] = ["#{ENV['HOME']}/.ec2/key.pem"]