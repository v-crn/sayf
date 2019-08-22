require 'test_helper'

class SayingsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    Warden.test_mode!
    @saying = sayings(:most_recent)
  end

  test 'should redirect create when not logged in' do
    assert_no_difference 'Saying.count' do
      post sayings_path, params: { saying: { content: 'Lorem ipsum' } }
    end
    assert_redirected_to new_user_session_path
  end

  test 'should redirect destroy when not logged in' do
    assert_no_difference 'Saying.count' do
      delete saying_path(@saying)
    end
    assert_redirected_to new_user_session_path
  end

  test 'should redirect destroy for wrong saying' do
    sign_in(users(:john))
    saying = sayings(:ants)
    assert_no_difference 'Saying.count' do
      delete saying_path(saying)
    end
    assert_redirected_to root_url
  end
end
