module LightScaffold
  class Responder < ActionController::Responder
    GENERIC_VIEWS_PATH = "scaffold"

    def to_html
      if get?
        render :action => "#{GENERIC_VIEWS_PATH}/#{controller.action_name}"
      elsif has_errors?
        render :action => "#{GENERIC_VIEWS_PATH}/#{(post? ? :new : :edit)}"
      else
        redirect_to resource
      end
    end
  end
end
