package :root do
  requires :root_setup, :root_keys, :root_known_hosts
end

# Create the ssh setup for root
package :root_setup do
  noop do
    pre :install, 'mkdir -p /root/.ssh'
    pre :install, 'touch /root/.ssh/authorized_keys'
    pre :install, 'touch /root/.ssh/known_hosts'
  end

  verify do
    has_file '/root/.ssh/authorized_keys'
  end
end

# Add keys to the auth keys of root, to allow people to ssh into root
package :root_keys do
  config_file = '/root/.ssh/authorized_keys'
  config_text = File.open(MY_PUBLIC_KEY,'rb').read
  push_text config_text, config_file

  verify do
    file_contains config_file, "curt@Rooster.local"
  end
end

package :root_known_hosts do
  config_file = '/root/.ssh/known_hosts'
  noop do
    GIT_REPO_DOMAINS.each do |domain|
      pre :install, "ssh-keyscan -t rsa #{domain} >> #{config_file}"
    end
  end

  verify do
    file_contains config_file, "github.com"
  end
end

package :deploy do
  # requires :deploy_user, :deploy_id_rsa, :deploy_id_rsa_pub, :deploy_sudoers
  requires :deploy_user, :deploy_id_rsa, :deploy_id_rsa_pub, :deploy_sudoers, :curt_user, :curt_sudoers
end

# Add a deploy user and create everything they'll ever need
package :deploy_user do
  noop do
    pre :install, 'groupadd deploy'
    pre :install, 'useradd -m -g deploy deploy'
    pre :install, 'mkdir -p /home/deploy/.ssh'
    pre :install, 'touch /home/deploy/.ssh/id_rsa'
    pre :install, 'touch /home/deploy/.ssh/id_rsa.pub'
    pre :install, 'touch /home/deploy/.ssh/known_hosts'
    pre :install, 'cp /root/.ssh/authorized_keys /home/deploy/.ssh/authorized_keys'
    pre :install, 'cp /root/.ssh/known_hosts /home/deploy/.ssh/known_hosts'
    pre :install, 'chown -R deploy:deploy /home/deploy/.ssh/'
    pre :install, 'chmod 0600 /home/deploy/.ssh/id_rsa'
    # pre :install, 'mkdir /home/deploy/apps'
    pre :install, 'usermod -s /bin/bash deploy'
  end

  verify do
    has_file '/home/deploy/.ssh/id_rsa'
    has_file '/home/deploy/.ssh/authorized_keys'
    has_file '/home/deploy/.ssh/known_hosts'
  end
end

# Push a previously generated private ssh key into the deploy user
package :deploy_id_rsa do
  config_file = '/home/deploy/.ssh/id_rsa'
  config_text = File.open(DEPLOY_PRIVATE_KEY,'rb').read
  push_text config_text, config_file

  verify do
    file_contains config_file, "END RSA PRIVATE KEY"
  end
end

# Same thing as above but with the public key
package :deploy_id_rsa_pub do
  config_file = '/home/deploy/.ssh/id_rsa.pub'
  config_text = File.open(DEPLOY_PUBLIC_KEY,'rb').read
  push_text config_text, config_file

  verify do
    file_contains config_file, "deploy_affy@affygility.com"
  end
end

# Add deploy to the sudoers list
package :deploy_sudoers do
  config_file = '/etc/sudoers'
  config_text = %q[
deploy ALL=NOPASSWD: ALL
].lstrip

  push_text config_text, config_file

  verify do
    file_contains config_file, "deploy ALL=NOPASSWD: ALL"
  end
end

# What the hell, add 'curt' user so I can ssh without the username
package :curt do
  requires :curt_user, :curt_sudoers
end

# Add a curt user and create everything they'll ever need
package :curt_user do
  noop do
    pre :install, 'useradd -m -g deploy curt'
    pre :install, 'mkdir -p /home/curt/.ssh'
    pre :install, 'touch /home/curt/.ssh/id_rsa'
    pre :install, 'touch /home/curt/.ssh/id_rsa.pub'
    pre :install, 'touch /home/curt/.ssh/known_hosts'
    pre :install, 'cp /root/.ssh/authorized_keys /home/curt/.ssh/authorized_keys'
    pre :install, 'cp /root/.ssh/known_hosts /home/curt/.ssh/known_hosts'
    pre :install, 'chown -R curt:deploy /home/curt/.ssh/'
    pre :install, 'chmod 0600 /home/curt/.ssh/id_rsa'
    pre :install, 'usermod -s /bin/bash curt'
  end

  verify do
    has_file '/home/curt/.ssh/id_rsa'
    has_file '/home/curt/.ssh/authorized_keys'
    has_file '/home/curt/.ssh/known_hosts'
  end
end

# Add curt to the sudoers list
package :curt_sudoers do
  config_file = '/etc/sudoers'
  config_text = %q[
curt ALL=NOPASSWD: ALL
].lstrip

  push_text config_text, config_file

  verify do
    file_contains config_file, "curt ALL=NOPASSWD: ALL"
  end
end

