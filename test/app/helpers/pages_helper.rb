module PagesHelper
  include LightScaffold::Helper
 
  text_area 'content'
  # or
  #
  # def content_form_column(form, object)
  #  form.text_area 'content'
  # end

  text_field 'title', :class => 'big'
  # or 
  #
  # def title_form_column(form, object)
  #   form.text_field 'title', :class => 'big'
  # end

  index_columns :title
  # or
  #
  # def form_columns
  #   'title'
  # end
end
