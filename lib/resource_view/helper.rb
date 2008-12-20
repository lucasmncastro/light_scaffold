module ResourceView
  module Helper
    def collection_label
      model.to_s.pluralize.humanize
    end

    def object_label
      model.to_s.humanize
    end
    
    def columns
      model.column_names - %w(id created_at updated_at password)
    end
    
    [:index_columns, :show_columns, :form_columns].each do |method|
      define_method(method) { columns }
    end

    def show_column(column, record)
      if @template.respond_to?(helper = "#{column}_column")
        @template.send helper, record
      else
        record.send column
      end
    end
  end
end
