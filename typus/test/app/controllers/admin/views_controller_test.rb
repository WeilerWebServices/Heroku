require "test_helper"

=begin

  What's being tested here?

    - `set_context` which forces the display of items related to domain.

=end

class Admin::ViewsControllerTest < ActionController::TestCase

  setup do
    @request.session[:typus_user_id] = Factory(:typus_user).id
    @site = Factory(:site, :domain => 'test.host')
    view = Factory(:view, :site => @site)
    view = Factory(:view)
  end

  teardown do
    @request.session[:typus_user_id] = nil
  end

  test "get :index returns only views on the current_context" do
    get :index
    assert_response :success
    assert_equal [@site.id], assigns(:items).map(&:site_id)
  end

  test "get :new should initialize item in the current_scope" do
    get :new
    assert_response :success
    assert assigns(:item).site_id.eql?(@site.id)
  end

end
