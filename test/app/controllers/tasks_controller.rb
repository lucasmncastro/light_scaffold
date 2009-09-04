# Scaffold with Inherited Resources and LightScaffold::Renderer using only generic views.
class TasksController < InheritedResources::Base

  protected
  def responder
    LightScaffold::Responder
  end
end
