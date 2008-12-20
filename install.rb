require 'fileutils'

# Copy views dir.

FileUtils.mkdir "#{RAILS_ROOT}/app/views/scaffold"
FileUtils.cp_r 'views/scaffold', "#{RAILS_ROOT}/app/views/scaffold"
