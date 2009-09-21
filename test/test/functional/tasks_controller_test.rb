require 'test_helper'

class TasksControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tasks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create task" do
    assert_difference('Task.count') do
      post :create, :task => {:description => 'do it yourself'}
    end

    assert_redirected_to task_path(assigns(:task))
  end

  test "should show task" do
    get :show, :id => tasks(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => tasks(:one).to_param
    assert_response :success
  end

  test "should update task" do
    put :update, :id => tasks(:one).to_param, :task => { }
    assert_redirected_to task_path(assigns(:task))
  end

  test "should destroy task" do
    assert_difference('Task.count', -1) do
      delete :destroy, :id => tasks(:one).to_param
    end

    assert_redirected_to tasks_path
  end

  test "should show the id, description and status on :index" do
    get :index
    
    assert_tag :tag => "th", :content => /Id/
    assert_tag :tag => "th", :content => /Description/
    assert_tag :tag => "th", :content => /Status/
    
    assert_tag :tag => "td", :content => /#{tasks(:one).id}/
    assert_tag :tag => "td", :content => /#{tasks(:one).description}/
    assert_tag :tag => "td", :content => /#{tasks(:one).status}/
  end

  test "should show only description and status on :show" do
    get :show, :id => tasks(:one)
    assert_tag :tag => "dt", :content => /Description/
    assert_tag :tag => "dd", :content => /#{tasks(:one).description}/
    
    assert_tag :tag => "dt", :content => /Status/
    assert_tag :tag => "dd", :content => /#{tasks(:one).status}/
        
    assert_no_tag :tag => "dt", :content => /Id/
  end

  test "should show the description field under <strong> on :index" do
    get :index
    assert_tag :tag => "strong", :content => tasks(:one).description
  end

  test "should use checkbox to the status field on :new" do
    get :new
    assert_tag :tag => "input", :attributes => {:id => "task_status", :type => "checkbox"}
  end  

  test "should use textarea to the description field on :new" do
    get :new
    assert_tag :tag => "textarea", :attributes => {:id => "task_description"}
  end

  test "should show the magic field on :new" do
    get :new
    assert_tag :tag => "input", :attributes => {:id => "task_magic"}
  end  
end
