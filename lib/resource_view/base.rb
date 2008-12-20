module ResourceView
  class Base < ApplicationController
    unloadable

    def self.inherited(subclass)
      super
      subclass.class_eval do 
        resource_controller
        resource_view      
      end
    end
  end
end
