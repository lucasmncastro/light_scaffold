module ResourceView
  module ActionControllerExtension
    def resource_view
      include ResourceView::Controller
    end
  end
  
  # TODO This is not cool. Move to another plugin or to trash.
  module ActiveRecordExtension
    def self.extended(base)
      base.instance_eval do
        def human_attribute_name(attr)
          if respond_to?(method = "#{attr}_label")
            send method
          else
            attr.to_s.humanize
          end
        end
        def labels(hash)
          for attr, label in hash
            instance_eval "def #{attr}_label; '#{label}' end"
          end
        end
      end
    end
  end  
end
