require 'test_helper'

class ParentsControllerTest < ActionController::TestCase
  setup do
    @parent = parents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:parents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create parent" do
    assert_difference('Parent.count') do
      post :create, parent: { address: @parent.address, city: @parent.city, email: @parent.email, email_confirmed: @parent.email_confirmed, first_name: @parent.first_name, last_name: @parent.last_name, password_digest: @parent.password_digest, phone_number: @parent.phone_number, state: @parent.state, zip: @parent.zip }
    end

    assert_redirected_to parent_path(assigns(:parent))
  end

  test "should show parent" do
    get :show, id: @parent
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @parent
    assert_response :success
  end

  test "should update parent" do
    patch :update, id: @parent, parent: { address: @parent.address, city: @parent.city, email: @parent.email, email_confirmed: @parent.email_confirmed, first_name: @parent.first_name, last_name: @parent.last_name, password_digest: @parent.password_digest, phone_number: @parent.phone_number, state: @parent.state, zip: @parent.zip }
    assert_redirected_to parent_path(assigns(:parent))
  end

  test "should destroy parent" do
    assert_difference('Parent.count', -1) do
      delete :destroy, id: @parent
    end

    assert_redirected_to parents_path
  end
end
