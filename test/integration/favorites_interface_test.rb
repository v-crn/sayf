require 'test_helper'

class FavoritesInterfaceTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    Warden.test_mode!
    @user = users(:john)
    @saying = Saying.first
  end

  test 'favorite interface' do
    get root_path
    assert_select 'div#favorite_button'
    assert_match @saying.favorites.count.to_s, response.body
    sign_in(@user)
    get root_path
    # 無効な送信でParameterMissingエラー
    assert_raises ActionController::ParameterMissing do
      post favorites_path, params: { saying_id: nil }
    end
    # 有効な送信
    assert_difference 'Favorite.count', 1 do
      post favorites_path, params: { saying_id: @saying.id }, xhr: true
    end
    # お気に入りポイントを一つ減らす
    assert_select 'input', value: '-'
    favorite = @user.favorites.first
    assert_difference 'Favorite.count', -1 do
      delete favorite_path(favorite), params: { id: favorite.id }, xhr: true
    end
  end

  test 'favorite points' do
    sign_in(@user)
    @user.like(Saying.all.sample)
    get favorite_sayings_user_path(@user.id)
    assert_match "Favorite Sayings (#{@user.fav_sayings.count})", response.body
    fav_saying = @user.fav_sayings.last
    assert_match "#{fav_saying.favorite_points_by(@user)} / #{fav_saying.favorites.count}", response.body
  end
end
