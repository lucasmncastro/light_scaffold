require 'test_helper'

class HelperTest < ActionController::TestCase
  fixtures :tasks
  
  def setup
    @controller = TasksController.new
  end
  
  test "should not show priority column on :index" do
    get :index
    assert_tag :tag => "th", :content => "Description"    
    assert_no_tag :tag => "th", :content => "Priority"
  end

  test "should show description under <strong> on :index" do
    get :index
    assert_tag :tag => "strong", :content => tasks(:one).description
  end

  test "should show textarea to description column on :new" do
    get :new
    assert_tag :tag => "textarea", :attributes => {:id => "task_description"}
  end
end  
