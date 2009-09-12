module TasksHelper
  include LightScaffold::Helper
  
  def fields
    [:description, :status]
  end
  
  def index_fields
    [:id] + fields
  end

  # No show_fields definition.
  # def show_fields
  #   super
  # end
  
  def form_fields
    [:description, :status, :magic]
  end

  def status_field(form, resource)
    form.check_box :status
  end
  
  def description_field(form, resource)
    form.text_area :description
  end

  def formatted_description(resource)
    content_tag :strong, resource.description
  end
  
end
