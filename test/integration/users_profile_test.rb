require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
	include ApplicationHelper

  def setup
		@user = users(:john)
		# @pagy, @sayings = pagy(@user.sayings, count: 10)
  end

  test "profile display" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_select 'h1', text: @user.name
    assert_select 'img.icon_image'
    # assert_match @user.sayings.count.to_s, response.body
		# @user.sayings.paginate(page: 1).each do |saying|
		# pagy_bootstrap_nav(@pagy).each do |saying|
      # assert_match saying.content, response.body
    # end
  end
end
