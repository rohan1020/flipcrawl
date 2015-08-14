require 'test_helper'

class BookinfosControllerTest < ActionController::TestCase
  setup do
    @bookinfo = bookinfos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bookinfos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bookinfo" do
    assert_difference('Bookinfo.count') do
      post :create, bookinfo: { author: @bookinfo.author, categories: @bookinfo.categories, imgs: @bookinfo.imgs, mainimg: @bookinfo.mainimg, metadata: @bookinfo.metadata, pid: @bookinfo.pid, price: @bookinfo.price, title: @bookinfo.title, url: @bookinfo.url }
    end

    assert_redirected_to bookinfo_path(assigns(:bookinfo))
  end

  test "should show bookinfo" do
    get :show, id: @bookinfo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bookinfo
    assert_response :success
  end

  test "should update bookinfo" do
    patch :update, id: @bookinfo, bookinfo: { author: @bookinfo.author, categories: @bookinfo.categories, imgs: @bookinfo.imgs, mainimg: @bookinfo.mainimg, metadata: @bookinfo.metadata, pid: @bookinfo.pid, price: @bookinfo.price, title: @bookinfo.title, url: @bookinfo.url }
    assert_redirected_to bookinfo_path(assigns(:bookinfo))
  end

  test "should destroy bookinfo" do
    assert_difference('Bookinfo.count', -1) do
      delete :destroy, id: @bookinfo
    end

    assert_redirected_to bookinfos_path
  end
end
