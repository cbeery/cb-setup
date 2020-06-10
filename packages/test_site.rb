package :test_site do
  description 'Just a quick site for testing'
  noop do
    pre :install, 'mkdir /var/www/apps/cbsite/current'
    pre :install, 'mkdir /var/www/apps/cbsite/current/public'
    pre :install, 'echo "<h1>Fuck</h1>" > /var/www/apps/cbsite/current/public/index.html'

    pre :install, "chown -R deploy:deploy /var/www/apps/cbsite/current/"
    pre :install, "chmod -R ug=rwx /var/www/apps/cbsite/current/"

  end

  verify do
    has_directory '/var/www/apps/cbsite/current'
    has_directory '/var/www/apps/cbsite/current/public'
    has_file '/var/www/apps/cbsite/current/public/index.html'
  end
end