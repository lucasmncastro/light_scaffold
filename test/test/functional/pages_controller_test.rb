require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  fixtures :pages

  def test_get_index_should_fecth_all_the_pages
    get :index

    assert assigns(:pages)
    assert_tag :tag => 'h1', :content => "List of Pages"
  end

  def test_get_show_should_show_record_details
    page = pages(:welcome)
    get :show, {:id => page}

    assert assigns(:page)

    # dl with for 2 fields (title, content) = 4 children
    assert_tag :tag => 'dl',
               :children => {:count => 4}

    assert_tag :tag => 'a', 
               :attributes => {:href => /#{page_path(page)}/}, 
               :content => 'Edit'
  end
end
