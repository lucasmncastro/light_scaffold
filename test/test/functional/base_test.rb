require 'test_helper'

class BaseTest < ActiveSupport::TestCase

  test "should inherit from ApplicationController" do
    assert_equal LightScaffold::Base.superclass, ApplicationController
  end

  test "should include moculde for controller of light_scaffold" do
    assert PagesController.included_modules.include?(LightScaffold::Controller)
  end

  test "should include module for controller of resource_controller" do
    assert PagesController.included_modules.include?(ResourceController::Controller)
  end

end
