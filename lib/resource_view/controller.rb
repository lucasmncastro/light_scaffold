module ResourceView
  module Controller
    def self.included(klass)
      klass.class_eval do
        include ResourceView::Helper
        
        helper_method ResourceView::Helper.instance_methods + [:template_exists?]
      
        def try_render_scaffold_template(action_name = self.action_name)
          render
	rescue
          render :template => "scaffold/#{action_name}"
        end

        index.wants.html do
          try_render_scaffold_template
        end

        edit.wants.html do
          try_render_scaffold_template 
        end

        new_action.wants.html do
          try_render_scaffold_template 'new'
        end

        show do
          wants.html { try_render_scaffold_template }
          failure.wants.haml { render :text => 'Membro nao encontrado.' }
        end
       
        create do
          flash 'Criado com sucesso!'
          wants.html { redirect_to object_url }
          failure.wants.html { try_render_scaffold_template 'new' }
        end

        update do
          flash 'Atualizado com sucesso!'
          wants.html { redirect_to object_url }
          failure.wants.html { try_render_scaffold_template 'edit' }
        end
        
        destroy do
          flash 'Removido com sucesso!'
          wants.html { redirect_to collection_url }
        end      
      end
    end
  end
end
