# Start here

# Fill host_address in
set :host_address, "127.0.0.1"
set :port, 2222

# Fill user in - if remote user is different to your local user
set :user, "root"
set :password, "curt"

role :app, host_address
role :web, host_address
role :db,  host_address, :primary => true

set :use_sudo, false

# Fill options below if you wish to use public/private-key auth instead of password one
default_run_options[:pty] = true
# ssh_options[:user] = "root"
# ssh_options[:keys] = ["/Users/curtbeery/.vagrant.d/insecure_private_key"]
