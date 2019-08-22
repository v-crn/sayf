require 'test_helper'

class FavoritesControllerTest < ActionDispatch::IntegrationTest
  test 'create should require logged-in user' do
    assert_no_difference 'Favorite.count' do
      post favorites_path
    end
    assert_redirected_to new_user_session_path
  end

  test 'destroy should require logged-in user' do
    assert_no_difference 'Favorite.count' do
      delete favorite_path(favorites(:one))
    end
    assert_redirected_to new_user_session_path
  end
end
