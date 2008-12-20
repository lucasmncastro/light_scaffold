require 'fileutils'

scaffold_views = File.join %W(#{RAILS_ROOT} app views scaffold)
FileUtils.mkdir scaffold_views

source = File.join %w(vendor plugins resource_view views scaffold/.)
FileUtils.cp_r source, scaffold_views
