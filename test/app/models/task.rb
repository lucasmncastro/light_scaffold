class Task < ActiveRecord::Base
  attr_accessor :magic
  validates_presence_of :description
end
