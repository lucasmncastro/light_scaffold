module LightScaffold

  # This helper can be included in a helper to easility writing generic views;
  #
  # Some methods define which columns will show on index, show and form views:
  # columns, index_columns, show_columns and form_columns
  module Helper
    def self.included(base)
      base.send :include, LightScaffold::Helper::InstanceMethods
      base.send :extend,  LightScaffold::Helper::ClassMethods
    end
   
    COLUMNS_METHODS = %w(index_columns show_columns form_columns)
    HIDE_COLUMNS    = %w(id created_at updated_at password)

    module InstanceMethods

      # By default, call the #columns method.
      # You are free to overrides this methods.
      COLUMNS_METHODS.each do |method|
        define_method(method) { columns }
      end

      # You are free to overrides this method.
      def columns
        resource_class.column_names - HIDE_COLUMNS
      end
      
      def resource_class
        controller_name.classify.constantize
      end
      
      # Helper used in index and show views to send show the value of a column.
      #
      # If exists a method ending with <column_name>_column, it will to be sent.
      def show_column(column, record)
        if @template.respond_to?(helper = "#{column}_column")
          @template.send helper, record
        else
          record.send column
        end
      end
    end

    # Some syntactic sugar for instance methods.
    module ClassMethods

      # Sugar for columns methods.
      # Warning: the following code is sour. :S
      (InstanceMethods.instance_methods - [:show_column]).each do |method|
        class_eval do
          define_method(method) do |*column_names|
            class_eval do
              define_method(method) { column_names.collect(&:to_s) }
            end
          end
        end
      end

      # Creates class methods with some names of Form Helpers methods.
      #
      # So, I can to do it:
      #   module PagesHelper
      #     text_field 'title', :class => 'strong'
      #   end
      #
      # The title_form_column method will be created.
      def method_missing(method_name, *args)
        helper_name = method_name.to_s
        return super unless ActionView::Helpers.instance_methods.include? helper_name

        field_name = args.first
  
        class_eval do
          define_method("#{field_name}_form_column") do |form, object|
            form.send(method_name, *args)
          end
        end
      end
    end
  end
end
