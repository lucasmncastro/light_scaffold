module LightScaffold
  module PathSet
    def self.included(klass)
      super
      klass.class_eval { alias_method_chain :find, :shared_views }
    end

    def find_with_shared_views(path, details = {}, prefix = nil, partial = false)
      find_without_shared_views(path, details, prefix, partial)
    rescue ActionView::MissingTemplate => original_exception
      begin
        find_without_shared_views(path, details, shared_views_prefix, partial)    
      rescue ActionView::MissingTemplate
        raise original_exception
      end
    end  
    
    def shared_views_prefix
      'scaffold'
    end
  end
end
