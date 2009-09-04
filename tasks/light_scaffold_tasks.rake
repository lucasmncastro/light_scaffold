require 'fileutils'

namespace :light_scaffold do

  desc "Copy views to app/views/scaffold for inherited resources"
  task :install_views do
    scaffold_views = File.join %W(#{RAILS_ROOT} app views scaffold)
    FileUtils.mkdir scaffold_views

    source = File.join %w(vendor plugins light_scaffold views scaffold/.)
    FileUtils.cp_r source, scaffold_views
  end

end

