package :goodies_test do
  description 'Different useful utilities required on the server (test)'
  #Sysadmin tools - just a test with one tool
  apt %w(nmap) do

  end

  verify do
    has_file '/usr/bin/nmap'
  end
  
end