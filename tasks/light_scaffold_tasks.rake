require 'fileutils'

namespace :light_scaffold do

  namespace :install do
    desc "Install generic views for inherited resources under app/views/scaffold."
    task :ir do
      copy_views_from('ir')
    end
  
    desc "Install generic views for inherited resources with web-app-theme under app/views/scaffold."
    task :ir_with_wat do
      copy_views_from('ir_with_wat')
    end
  
    def copy_views_from(dir)
      scaffold_views = File.join %W(#{RAILS_ROOT} app views scaffold)
      FileUtils.mkdir scaffold_views rescue puts 'Dir app/views/scaffold already exists.'
  
      source = File.join %W(vendor plugins light_scaffold views #{dir}/.)
      FileUtils.cp_r source, scaffold_views
      puts 'Successful copied.'
    end
  end

end

