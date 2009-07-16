require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  fixtures :pages

  # on GET :index

  def setup
    @welcome = pages(:welcome)
  end

  test 'on GET index should fetch the pages' do
    get :index
    assert assigns(:pages)
  end

  test 'on GET index should show only the title for record' do
    get :index
    assert_no_tag :tag => 'th', :content => 'Content'
  end

  test 'on GET index should show h1 with the title of listing' do
    get :index
    assert_tag :tag => 'h1', :content => "List of Pages"
  end

  test 'on GET index should show link to action :show' do
    get :index
    assert_link_to 'Show', page_path(@welcome)
  end

  test 'on GET index should show link to action :edit' do
    get :index
    assert_link_to 'Edit', edit_page_path(@welcome)
  end

  test 'on GET index should show link to action :delete' do
    get :index
    assert_link_to 'Delete', page_path(@welcome)
  end

  test 'on GET index should show link to action :new' do
    get :index
    assert_link_to 'New Page', new_page_path
  end


  # on GET :show
  
  test 'on GET show should show record details' do
    get_show

    assert assigns(:page)

    # dl with for 2 fields (title, content) = 4 children
    assert_tag :tag => 'dl', :children => {:count => 4}
  end

  test 'on GET show should show link to action :edit' do
    get_show
    assert_link_to 'Edit', edit_page_path(@welcome)
  end

  test 'on GET show should show link to action :back' do
    get_show
    assert_link_to 'Back', pages_path
  end

  # on GET :show
  
  test 'on GET new should show title field with css class :big' do
    get :new
    assert_tag :tag => 'input', :attributes => {:name => 'page[title]', :type => 'text', :class => 'big'}
  end


  test 'on GET new should show content field with textarea' do
    get :new
    assert_tag :tag => 'textarea', :attributes => {:name => 'page[content]'}
  end

  # helpers

  private
    def get_show
      get :show, {:id => @welcome}
    end

    def assert_link_to(title, piece_of_url)
      assert_tag :tag => 'a',
                 :attributes => {:href => /#{piece_of_url}/},
                 :content => title
    end
end
