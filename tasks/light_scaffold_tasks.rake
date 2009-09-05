require 'fileutils'

namespace :light_scaffold do

  desc "Install generic views for inherited resources under app/views/scaffold."
  task :inherited_resources do
    copy_views_from('inherited_resources')
  end

  def copy_views_from(dir)
    scaffold_views = File.join %W(#{RAILS_ROOT} app views scaffold)
    FileUtils.mkdir scaffold_views rescue puts 'Dir app/views/scaffold already exists.'

    source = File.join %W(vendor plugins light_scaffold views #{dir}/.)
    FileUtils.cp_r source, scaffold_views
    puts 'Successful copied.'
  end

end

