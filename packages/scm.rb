# Source control (Git)
package :git, :provides => :scm do
  description 'Git Version Control System'

  apt 'git'

  verify do
    has_executable 'git'
  end
end
