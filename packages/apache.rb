package :apache, :provides => :webserver do
  description 'Apache2 web server.'
  apt 'apache2 apache2.2-common apache2-mpm-prefork apache2-utils libexpat1 ssl-cert' do
    post :install, 'a2enmod rewrite ssl'
  end

  verify do
    has_executable '/usr/sbin/apache2'
  end

  requires :build_essential, :apache_dependencies
  optional :apache_etag_support, :apache_deflate_support, :apache_expires_support
end

package :apache_dependencies do
  description 'Apache 2 HTTP Server Build Dependencies'
  # apt %w( openssl libtool mawk zlib1g-dev libssl-dev libcurl4-openssl-dev libapr1-dev libaprutil1-dev libexpat1 ssl-cert )
  apt %w( libcurl4-openssl-dev apache2-prefork-dev libapr1-dev libaprutil1-dev )

  # TODO verify apache dependencies
end

package :additional_apache_config_file do
  description 'Create file to include for additional Apache configuration'
  noop do
    pre :install, "touch #{MY_APACHE_CONFIG}"
  end

  verify do
    has_file MY_APACHE_CONFIG
  end
end

package :apache_etag_support do
  load_file = MY_APACHE_CONFIG
  push_text File.read('configs/apache/apache_etag_support'), load_file

  verify do
    file_contains load_file, 'FileETag'
  end

  requires :additional_apache_config_file
end

package :apache_deflate_support do
  load_file = MY_APACHE_CONFIG
  push_text File.read('configs/apache/apache_deflate_support'), load_file

  verify do
    file_contains load_file, 'DEFLATE'
  end

  requires :additional_apache_config_file
end

package :apache_expires_support do
  load_file = MY_APACHE_CONFIG
  push_text File.read('configs/apache/apache_expires_support'), load_file

  verify do
    file_contains load_file, 'ExpiresActive'
  end

  requires :additional_apache_config_file
end
