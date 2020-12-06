require 'test_helper'

class CreateRoomControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get create_room_index_url
    assert_response :success
  end

  test "should get post" do
    get create_room_post_url
    assert_response :success
  end

end
