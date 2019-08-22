require 'test_helper'

class FavoriteTest < ActiveSupport::TestCase
  include Devise::Test::IntegrationHelpers

  def setup
    Warden.test_mode!
    @user = users(:john)
    @saying = sayings(:most_recent)
    @favorites = Favorite.new(user_id: @user.id,
                              saying_id: @saying.id,
                              points: 1)
  end

  test 'should be valid' do
    assert @favorites.valid?
  end

  test 'should require a user_id' do
    @favorites.user_id = nil
    assert_not @favorites.valid?
  end

  test 'should require a saying_id' do
    @favorites.saying_id = nil
    assert_not @favorites.valid?
  end
end
