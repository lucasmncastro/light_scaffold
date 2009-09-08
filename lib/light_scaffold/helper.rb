module LightScaffold

  # This helper can be included in a helper to easility writing generic views;
  #
  # Some methods define which fields will show on index, show and form views:
  # fields, index_fields, show_fields and form_fields
  module Helper
    def self.included(base)
      base.send :include, LightScaffold::Helper::InstanceMethods
      base.send :extend,  LightScaffold::Helper::ClassMethods
    end
   
    COLUMNS_METHODS = %w(index_fields show_fields form_fields)
    HIDE_COLUMNS    = %w(id created_at updated_at password)

    module InstanceMethods

      # By default, call the #fields method.
      # You are free to overrides this methods.
      COLUMNS_METHODS.each do |method|
        define_method(method) { fields }
      end

      # You are free to overrides this method.
      def fields
        resource_class.column_names - HIDE_COLUMNS
      end
      
      def resource_class
        controller_name.classify.constantize
      end
      
      # Helper used in index and show views to send show the value of a field.
      #
      # If exists a method ending with <field_name>_field, it will to be sent.
      def show_field(field, record)
        if @template.respond_to?(helper = "#{field}_field")
          @template.send helper, record
        else
          record.send field
        end
      end
    end

    # Some syntactic sugar for instance methods.
    module ClassMethods

      # Sugar for fields methods.
      # Warning: the following code is sour. :S
      (InstanceMethods.instance_methods - [:show_field]).each do |method|
        class_eval do
          define_method(method) do |*fields|
            class_eval do
              define_method(method) { fields.collect(&:to_s) }
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
      # The title_form_field method will be created.
      def method_missing(method_name, *args)
        return super unless ActionView::Helpers.instance_methods.include? method_name.to_s

        field_name = args.first
  
        class_eval do
          define_method("#{field_name}_form_field") do |form, object|
            form.send(method_name, *args)
          end
        end
      end
    end
  end
end
