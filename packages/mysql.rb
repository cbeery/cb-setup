package :mysql, :provides => :database do
  requires :mysql_executables, :mysql_driver, :mysql_user
end

package :mysql_executables do
  description 'MySQL Database'
  apt %w( mysql-server mysql-client libmysqlclient15-dev )

  verify do
    has_executable 'mysql'
  end
end
 
package :mysql_driver do
  description 'Ruby MySQL database driver'
  requires :ruby, :mysql_executables
  gem 'mysql2'
  
  verify do
    has_gem 'mysql2'
  end
end

package :mysql_user do
  description 'Add database and user'
  requires :mysql_executables
  db_name = "#{APP_NAME}_production"
  runner "mysql -uroot -e \"create database if not exists #{db_name}; grant all on #{db_name}.* to #{MYSQL_USER}@localhost identified by '#{MYSQL_PW}';\""
end