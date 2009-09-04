require 'test_helper'

class ResponderTest < ActionController::TestCase
  
  test "should get :new with own view" do
    @controller = TicketsController.new
    get :index
    assert_response :success
    assert_tag :tag => "span", :content => "own view"
  end

  test "should get :index with generic view" do
    @controller = TasksController.new
    get :index
    assert_response :success
    assert_tag :tag => "span", :content => "generic view"
  end
end  
