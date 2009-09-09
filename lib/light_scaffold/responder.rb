module LightScaffold
  class Responder < ActionController::Responder
    def shared_views_path 
      'scaffold'
    end
    
    def to_html
      if get?
        render "#{shared_views_path}/#{controller.action_name}"
      elsif has_errors?
        render "#{shared_views_path}/#{default_action}"
      else
        redirect_to resource
      end
    end
  end
end
