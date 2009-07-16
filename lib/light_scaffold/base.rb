module LightScaffold
  class Base < ApplicationController
    unloadable

    def self.inherited(subclass)
      super
      subclass.class_eval do 
        resource_controller
	light_scaffold
      end
    end
  end
end
