require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
	def setup
    @user = users(:user_0)
    @other_user = users(:user_1)
  end

	test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to new_user_session_path
	end
	
  test "should redirect following when not logged in" do
    get following_user_path(@user)
    assert_redirected_to new_user_session_path
  end

  test "should redirect followers when not logged in" do
    get followers_user_path(@user)
    assert_redirected_to new_user_session_path
  end
end
