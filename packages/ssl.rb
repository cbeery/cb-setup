package :ssl do
  requires :ssl_directory, :ssl_cert, :ssl_key, :ssl_chain
end

package :ssl_directory do
  noop do
    pre :install, "mkdir -p #{APACHE_SSL_DIR}"
  end

  verify do
    has_directory APACHE_SSL_DIR
  end
end

package :ssl_cert do
  requires :ssl_directory
  cert_file = "#{APACHE_SSL_DIR}/star_affytrac_com.crt"

  push_text File.read(SSL_CERT), cert_file

  verify do
    has_file cert_file
  end
end

package :ssl_key do
  requires :ssl_directory
  key_file = "#{APACHE_SSL_DIR}/star_affytrac_com.key"

  push_text File.read(SSL_KEY), key_file

  verify do
    has_file key_file
  end
end

package :ssl_chain do
  requires :ssl_directory
  chain_file = "#{APACHE_SSL_DIR}/DigiCertCA.crt"

  push_text File.read(SSL_CHAIN), chain_file

  verify do
    has_file chain_file
  end
end
