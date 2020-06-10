package :ruby do
	# https://www.brightbox.com/blog/2017/01/13/ruby-2-4-ubuntu-packages/
  description 'Ruby 2.4'
  apt 'ruby2.4 ruby2.4-dev' do
    pre :install, 'sudo apt-add-repository ppa:brightbox/ruby-ng -y'
    pre :install, 'sudo apt-get update'
  end

  # verify { has_executable_with_version "/usr/local/bin/ruby", version }
  # verify { has_executable_with_version "/usr/local/bin/ruby", '2.4.9' }
  verify { has_executable_with_version "/usr/bin/ruby", '2.4.9' }
end

## NOT WORKING!!!