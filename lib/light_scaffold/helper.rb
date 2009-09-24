module LightScaffold

  # This helper can be included in a helper to easility writing shared views;
  #
  # Some methods define which fields will show on index, show and form views:
  # fields, index_fields, show_fields, form_fields, new_fields and edit_fields.
  module Helper
    def self.included(base)
      base.send :include, LightScaffold::Helper::InstanceMethods
      base.send :extend,  LightScaffold::Helper::ClassMethods
    end
   
    module InstanceMethods
      def resource_class
        controller_name.classify.constantize
      end

      def fields
        resource_class.column_names - hidden_fields
      end
      
      def hidden_fields
        %w(id created_at updated_at password)
      end

      def index_fields
        fields
      end
      
      def show_fields 
        fields 
      end
      
      def form_fields
        fields
      end
      
      def display_field(field, resource)
        if respond_to?(helper = "formatted_#{field}")
          send helper, resource
        else
          default_display_field field, resource
        end
      end
      
      def default_display_field(field, resource)
        resource.send field
      end
      
      def form_field(form, field, resource)
        if respond_to?(helper = "#{field}_form_field")
          send helper, form, resource
        else
          default_form_field form, field, resource
        end
      end
      
      def default_form_field(form, field, resource)
        form.text_field field
      end
    end

    # Some syntactic sugar for instance methods.
    module ClassMethods

      # Sugar for fields methods.
      InstanceMethods.instance_methods.select {|method| method.ends_with?('_fields')}.each do |method|
        instance_eval do
          define_method(method) do |*fields|
            define_method(method) { fields.collect(&:to_s) }
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
        field = args.first
      
        define_method("#{field}_form_field") do |form, object|
          if form.respond_to? method_name
            form.send(method_name, *args)
          else
            raise NoMethodError, "this form builder doesn't respond to #{method_name}" 
          end  
        end
      end
    end
  end
end
