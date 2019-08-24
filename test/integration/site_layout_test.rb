require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    Warden.test_mode!
    @user = users(:john)
  end

  test 'layout links when not logged in' do
    get root_path
    assert_template 'static_pages/home'
    assert_select 'a[href=?]', root_path, count: 2
    assert_select 'a[href=?]', new_user_session_path
    assert_select 'a[href=?]', new_user_registration_path
    assert_select 'a[href=?]', about_path
    assert_select 'a[href=?]', contact_path
    get contact_path
    assert_select 'title', full_title('Contact')
  end

  test 'layout links when logged in' do
    sign_in(@user)
    get root_path
    assert_template 'static_pages/home'
    assert_select 'a[href=?]', users_path
    assert_select 'a[href=?]', user_path(@user)
    assert_select 'a[href=?]', edit_user_registration_path
    assert_select 'a[href=?]', destroy_user_session_path
    assert_select 'a[href=?]', following_user_path(@user.id)
    assert_select 'a[href=?]', followers_user_path(@user.id)
  end
end
