module LightScaffold
  module PathSet
    def self.included(klass)
      super
      klass.class_eval { alias_method_chain :find_template, :shared_views }
    end

    def find_template_with_shared_views(original_template_path, form = nil, html_fallback = true)
      find_template_without_shared_views(original_template_path, form, html_fallback)
    rescue ActionView::MissingTemplate => original_exception
      begin
        action_name = original_template_path.split('/').last
        find_template_without_shared_views("#{shared_views_prefix}/#{action_name}", form, html_fallback)
      rescue ActionView::MissingTemplate
        raise original_exception
      end
    end  
 
    def shared_views_prefix
      'scaffold'
    end
  end
end
