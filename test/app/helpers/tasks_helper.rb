module TasksHelper
  include LightScaffold::Helper
  
  def index_fields
    [:description]
  end
  # index_fields :description
  
  text_area :description

  def description_field(object)
    content_tag :strong, object.description
  end  
end
