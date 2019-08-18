require 'test_helper'

class SayingsInterfaceTest < ActionDispatch::IntegrationTest
	include Devise::Test::IntegrationHelpers
	
	def setup
		Warden.test_mode!
		@user = users(:john)
  end

  test "saying interface" do
    sign_in(@user)
    get root_path
		assert_select 'ol.sayings'
		assert_select 'input[type="file"]'
    # 無効な送信
    assert_no_difference 'Saying.count' do
      post sayings_path, params: { saying: { content: "" } }
    end
    assert_select 'div#error_explanation'
    # 有効な送信
    content = "This saying really ties the room together"
		picture = fixture_file_upload('test/fixtures/rails.png', 'image/png')
		assert_difference 'Saying.count', 1 do
			post sayings_path, params: { saying: { content: content,
																						picture: picture } }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body
    # 投稿を削除する
		assert_select 'a', text: 'delete'
		first_saying = @user.sayings.first
    assert_difference 'Saying.count', -1 do
      delete saying_path(first_saying)
    end
    # 違うユーザーのプロフィールにアクセス (削除リンクがないことを確認)
    get user_path(users(:user_0))
    assert_select 'a', text: 'delete', count: 0
  end
	
	test "saying sidebar count" do
    sign_in(@user)
    get root_path
    assert_match "#{@user.sayings.count} " + "saying".pluralize(@user.sayings.count), response.body
    # まだ投稿していないユーザー
    other_user = users(:user_1)
    sign_in(other_user)
    get root_path
    assert_match "0 sayings", response.body
    other_user.sayings.create!(content: "A saying")
    get root_path
    assert_match "1 saying", response.body
  end
end