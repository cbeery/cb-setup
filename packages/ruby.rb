package :ruby do
  requires :ruby_dependencies
  description 'Ruby Virtual Machine'
  version '1.9.3'
  patchlevel '286'

  source "ftp://ftp.ruby-lang.org/pub/ruby/1.9/ruby-#{version}-p#{patchlevel}.tar.gz" do
    pre :install, 'apt-get purge ruby ruby1.9 ruby1.9.1 rubygems1.8 rubygems1.9 rubygems1.9.1'
  end

  verify { has_executable_with_version "/usr/local/bin/ruby", version }
end

package :ruby_dependencies do
  description 'Ruby Virtual Machine Build Dependencies'
  # Changed name of readline package
  # apt %w( bison zlib1g-dev libssl-dev libreadline5-dev libncurses5-dev libyaml-0-2 file )
  apt %w( bison zlib1g-dev libssl-dev libreadline-dev libncurses5-dev libyaml-0-2 libyaml-dev file )

end
