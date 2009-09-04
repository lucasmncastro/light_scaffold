# Scaffold with Inherited Resources and LightScaffold::Responder using own views.
class TicketsController < InheritedResources::Base

  protected
  def responder
    LightScaffold::Responder
  end
end
