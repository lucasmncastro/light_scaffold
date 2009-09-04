module TasksHelper
  include LightScaffold::Helper
  
  index_columns :description
  
  text_area :description

  def description_column(object)
    content_tag :strong, object.description
  end  
end
