require 'test_helper'

class ResponderTest < ActionController::TestCase
  fixtures :tasks

  test "should render own view when it exists" do
    @controller = TicketsController.new
    get :index
    assert_response :success
    assert_tag :tag => "span", :content => "own view"
  end

  test "should render text when format.html render text" do
    override_format "render :text => '<p>Arrgg</p>'"
    
    get :show, :id => tasks(:one)
    assert_response :success
    assert_tag :p, :content => 'Arrgg'
  end

  test "should redirect when format.html send redirect_to" do
    override_format "redirect_to :action => 'index'"
    
    get :show, :id => tasks(:one)
    assert_response :redirect
  end

# The follows tests are commented because (I belive) there is a bug on Responder.
#  test "should raise exception when format.html render an unexisting view" do
#    override_format "render 'nothing'"
#    
#    assert_raise do
#      get :show, :id => tasks(:one)
#      assert_response :success
#    end
#  end

#  test "should raise exception when format.html render without arguments because template not exist" do
#    override_format "render"
#
#    assert_raise do
#      get :show, :id => tasks(:one)
#      assert_response :success
#    end
#  end

  test "should raise exception when format.html render a broken view" do
    override_format "render 'tickets/show'"
    
    assert_raise ActionView::TemplateError do
      get :show, :id => tasks(:one)
    end
  end

  def teardown
    override_format "render 'scaffold/show'"
  end

  private
  
  def override_format(code)
    TasksController.class_eval <<-CODE
      def show
        @task = Task.first
        respond_with(@task) do |format|
          format.html { #{code} }
        end
      end
    CODE
    @controller = TasksController.new
  end

end  
