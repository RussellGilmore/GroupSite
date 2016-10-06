require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get forum" do
    get :forum
    assert_response :success
  end

  test "should get text_chat" do
    get :text_chat
    assert_response :success
  end

  test "should get drive" do
    get :drive
    assert_response :success
  end

  test "should get video_chat" do
    get :video_chat
    assert_response :success
  end

end
