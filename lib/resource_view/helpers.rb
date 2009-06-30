module ResourceView
  module Helpers
    def collection_label
      model.human_name.pluralize
    end

    def object_label
      model.human_name
    end
    
    def columns
      model.column_names - %w(id created_at updated_at password)
    end
    
    [:index_columns, :show_columns, :form_columns].each do |method|
      define_method(method) { columns }
    end
  end
end
