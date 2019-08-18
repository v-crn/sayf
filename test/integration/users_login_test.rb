require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
	include Devise::Test::IntegrationHelpers

	def setup
		Warden.test_mode!
		@user = users(:john)
	end

	test "login with invalid information" do
		get new_user_session_path
		assert_template 'devise/sessions/new'
    post user_session_path, params: { session: { email: "", encrypted_password: "" } }
		assert_template 'devise/sessions/new'
		assert_select "div.alert-danger"
		get root_path
		assert_select "div.alert-danger", false
  end

	test "login with valid information followed by logout" do
		sign_in(@user)
		get user_path(@user)
    assert_select "a[href=?]", new_user_session_path, count: 0
    assert_select "a[href=?]", destroy_user_session_path
		assert_select "a[href=?]", user_path(@user)
		delete destroy_user_session_path
		assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", new_user_session_path
    assert_select "a[href=?]", destroy_user_session_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end
end
