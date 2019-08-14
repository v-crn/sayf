require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
	test "invalid signup information" do
    get new_user_session_path
    assert_no_difference 'User.count' do
      post user_registration_path, params: { user: { name:  "ｑうぇｒちゅいお",
																				 email: "user@invalid",
																				 icon: "https://2.bp.blogspot.com/-udq6-yh5Uwo/UbVvNJ8hc3I/AAAAAAAAUro/7g3NJ6uVfJQ/s800/computer_hacker.png",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template 'devise/registrations/new'
	end
	
	test "valid signup information" do
    get new_user_session_path
    assert_difference 'User.count', 1 do
      post user_registration_path, params: { user: { name:  "example user",
																				 email: "user@example.com",
																				 icon: "https://1.bp.blogspot.com/-fv0PKULcS_g/V5ND3noPfdI/AAAAAAAA8fM/0vqkeF1n-6kUguj3IWff3hDOh5KwzmqBwCLcB/s800/computer_hacker_white1.png",
                                         password:              "foobar",
                                         password_confirmation: "foobar" } }
    end
    assert_template root_path
  end
end
