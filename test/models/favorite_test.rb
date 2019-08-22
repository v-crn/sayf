require 'test_helper'

class FavoriteTest < ActiveSupport::TestCase
  include Devise::Test::IntegrationHelpers

  def setup
    Warden.test_mode!
    @user = users(:john)
    @saying = sayings(:most_recent)
    @favorite = Favorite.new(user_id: @user.id,
                             saying_id: @saying.id)
  end

  test 'should be valid' do
    assert @favorite.valid?
  end

  test 'should require a user_id' do
    @favorite.user_id = nil
    assert_not @favorite.valid?
  end

  test 'should require a saying_id' do
    @favorite.saying_id = nil
    assert_not @favorite.valid?
  end
end
