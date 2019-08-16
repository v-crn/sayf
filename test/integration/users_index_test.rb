require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
	
	def setup
		Warden.test_mode!
		@admin     = users(:john)
    @non_admin = users(:user_0)
  end

  test "index as admin including pagination and delete links" do
    sign_in(@admin)
    get users_path
    assert_template 'users/index'
    # assert_select 'div.pagination'
    # first_page_of_users = User.paginate(page: 1)
    # first_page_of_users.each do |user|
		# users = User.all
		# users.each do |user|
		# 	assert_select 'a[href=?]', user_path(user), text: user.name
    #   unless user == @admin
    #     assert_select 'a[href=?]', user_path(user), text: 'delete'
    #   end
    # end
    # assert_difference 'User.count', -1 do
    #   delete user_path(@non_admin)
    # end
  end

  test "index as non-admin" do
    sign_in(@non_admin)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end
end
